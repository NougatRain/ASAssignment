using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace ASAssignmentV3
{
    public partial class RegistrationForm : System.Web.UI.Page
    {

        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }



        private int checkPassword(string password)
        {
            int score = 0;

            //score 0 very weak!
            //if legnth of password is less than 8 chars
            if (password.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }
            //Score 2 Weak
            if (Regex.IsMatch(password, "[a-z]"))
            {
                score = 2;
            }
            //Score 3 Medium
            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score = 3;
            }
            //Score 4 Strong
            if (Regex.IsMatch(password, "[0-9]"))
            {
                score = 4;
            }
            //Score 5 Excellent
            if (Regex.IsMatch(password, "[!@#$%^&*]"))
            {
                score = 5;
            }

            return score;
        }

        protected void btn_checkPassword_Click1(object sender, EventArgs e)
        {
            int scores = checkPassword(tb_password.Text);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;
                case 2:
                    status = "Weak";
                    break;
                case 3:
                    status = "Medium";
                    break;
                case 4:
                    status = "Strong";
                    break;
                case 5:
                    status = "Excellent!";
                    break;
                default:
                    break;
            }
            lbl_pwdchecker.Text = "Status : " + status;
            if (scores < 4)
            {
                lbl_pwdchecker.ForeColor = Color.Red;
                return;
            }
            lbl_pwdchecker.ForeColor = Color.Green;
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            if (ValidateCaptcha())
            {
                //string pwd = get value from your Textbox
                string pwd = tb_password.Text.ToString().Trim();
                //Generate random "salt"
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                byte[] saltByte = new byte[8];
                //Fills array of bytes with a cryptographically strong sequence of random values.
                rng.GetBytes(saltByte);
                salt = Convert.ToBase64String(saltByte);
                SHA512Managed hashing = new SHA512Managed();
                string pwdWithSalt = pwd + salt;
                byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
                byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                finalHash = Convert.ToBase64String(hashWithSalt);
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.GenerateKey();
                Key = cipher.Key;
                IV = cipher.IV;
                createAccount();
                Response.Redirect("LoginForm.aspx");
            }
        }


        public void createAccount()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@Email, @FirstName, @LastName, @CreditCard, @DateOfBirth, @PasswordHash, @PasswordSalt, @Password)"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@Email", HttpUtility.HtmlEncode(tb_email.Text.Trim()));
                            cmd.Parameters.AddWithValue("@FirstName", HttpUtility.HtmlEncode(tb_fname.Text.Trim()));
                            cmd.Parameters.AddWithValue("@LastName", HttpUtility.HtmlEncode(tb_lname.Text.Trim()));
                            cmd.Parameters.AddWithValue("@CreditCard", Convert.ToBase64String(encryptData(HttpUtility.HtmlEncode(tb_credit.Text.Trim()))));
                            cmd.Parameters.AddWithValue("@DateOfBirth", HttpUtility.HtmlEncode(tb_dob.Text.Trim()));
                            cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@Password", HttpUtility.HtmlEncode(tb_password.Text.Trim()));
                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }


        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0,
               plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }

        protected void tb_dob_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btn_Login_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }

        public class Login
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }

        public bool ValidateCaptcha()
        {
            bool result = true;

            string captchaResponse = Request.Form["g-recaptcha-response"];

            HttpWebRequest req = (HttpWebRequest)WebRequest.Create("https://www.google.com/recaptcha/api/siteverify?secret=6Ld-rUoaAAAAAPFkAzVlUNztfllS6Bld9wwxp-Ai &response=" + captchaResponse);

            try
            {
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();

                        lbl_gScore.Text = jsonResponse.ToString();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        Login jsonObject = js.Deserialize<Login>(jsonResponse);

                        result = Convert.ToBoolean(jsonObject.success);
                    }
                }
                return result;
            }
            catch (WebException ex)
            {
                throw ex;
            }

        }
    }
}