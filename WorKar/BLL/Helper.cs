using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Runtime.InteropServices;

namespace WorKar.BLL
{
    public class Helper
    {
        // replace content of file
        public static string find_and_replace(string filename, string replaceText, string findText)
        {
            try
            {
                System.IO.StreamReader objReader;

                // read complete file and replacing rhe text
                objReader = new System.IO.StreamReader(filename);
                string content = objReader.ReadToEnd();
                objReader.Close();
                content = content.Replace(findText, replaceText);

                return content;
            }
            catch
            {
                return "";
            }
        }



        // send gmail with message 
        public static void send_email(MailMessage message)
        {

            SmtpClient client = new SmtpClient();
//            client.UseDefaultCredentials = true;

            try
            {
                client.Send(message);
                client.Dispose();
                client = null;
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        //this function Convert to Encord your Password 
        public static string EncodePasswordToBase64(string password)
        {
            try
            {
                byte[] encData_byte = new byte[password.Length];
                encData_byte = System.Text.Encoding.UTF8.GetBytes(password);
                string encodedData = Convert.ToBase64String(encData_byte);
                return encodedData;
            }
            catch (Exception ex)
            {
                throw new Exception("Error in base64Encode" + ex.Message);
            }
        } //this function Convert to Decord your Password
        public static string DecodeFrom64(string encodedData)
        {
            System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
            System.Text.Decoder utf8Decode = encoder.GetDecoder();
            byte[] todecode_byte = Convert.FromBase64String(encodedData);
            int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
            char[] decoded_char = new char[charCount];
            utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
            string result = new String(decoded_char);
            return result;
        }

    }
}