using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.SessionState;

namespace Inventory_App.Models
{
    public class SessionTimeoutAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpContext ctx = HttpContext.Current;
            HttpSessionState session = HttpContext.Current.Session;
            if (ctx.Session["UserID"] == null)
            {
                ctx.Session.Add("Sessiontimeout", "Session Timeout. Please Relogin");
                filterContext.Result = new RedirectToRouteResult(
                                  new RouteValueDictionary
                                  {
                                       { "action", "Index" },
                                       { "controller", "Login" }
                                  });
                return;
            }
            base.OnActionExecuting(filterContext);
        }
    }
}