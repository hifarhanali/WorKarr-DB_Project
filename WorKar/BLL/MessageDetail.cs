using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WorKar.BLL
{
    public class MessageDetail
    {
        public string FromUserName { get; set; }
        public string ToUserName { get; set; }
        public string Message { get; set; }
        public DateTime AddedOn { get; set; }
        public bool isFromDB { get; set; } = false;            // true if message is read from database
    }
}