using System.Web;
using System.Web.Optimization;

namespace Inventory_App
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.UseCdn = true;
            BundleTable.EnableOptimizations = true;

            //--------------------------- Script Bundles ---------------------------

            var jqueryBundle = new ScriptBundle("~/Scripts/jquery", "https://code.jquery.com/jquery-2.2.4.min.js").Include(
                "~/Scripts/jquery-{version}.js");
            jqueryBundle.CdnFallbackExpression = "window.jquery";
            bundles.Add(jqueryBundle);

            var MetisMenuScriptBundle = new ScriptBundle("~/Scripts/metisMenu", "https://cdnjs.cloudflare.com/ajax/libs/metisMenu/2.5.2/metisMenu.min.js").Include(
                "~/Scripts/metisMenu.min.js");
            bundles.Add(MetisMenuScriptBundle);

            var DatatablesScriptBundle = new ScriptBundle("~/Scripts/datatables", "https://cdn.datatables.net/v/dt/jszip-2.5.0/pdfmake-0.1.18/dt-1.10.12/b-1.2.2/b-colvis-1.2.2/b-html5-1.2.2/b-print-1.2.2/fh-3.1.2/r-2.1.0/datatables.min.js").Include(
                "~/Scripts/datatables.min.js");
            bundles.Add(DatatablesScriptBundle);

            bundles.Add(new ScriptBundle("~/Scripts/bootstrap").Include(
                "~/Scripts/bootstrap.js")
            );

            bundles.Add(new ScriptBundle("~/Scripts/LocalScripts").Include(
                "~/Scripts/site.js")
            );

            bundles.Add(new ScriptBundle("~/Scripts/modernizr").Include(
                "~/Scripts/modernizr-{version}.js")
            );

            //--------------------------- Style Bundles ---------------------------

            bundles.Add(new StyleBundle("~/Content/bootstrap").Include(
                "~/Content/bootstrap.css",
                "~/Content/bootstrap-theme.css"));

            bundles.Add(new StyleBundle("~/Content/Stylesheet/LocalStyles").Include(
                "~/Content/Stylesheet/site.css"));

            var DatatablesStyleBundle = new StyleBundle("~/Content/Stylesheet/datatables", "https://cdn.datatables.net/v/dt/jszip-2.5.0/pdfmake-0.1.18/dt-1.10.12/b-1.2.2/b-colvis-1.2.2/b-html5-1.2.2/b-print-1.2.2/fh-3.1.2/r-2.1.0/datatables.min.css").Include(
                "~/Content/Stylesheet/datatables.min.css");
            bundles.Add(DatatablesStyleBundle);

            var MetisMenuStyleBundle = new StyleBundle("~/Content/Stylesheet/metisMenu", "https://cdnjs.cloudflare.com/ajax/libs/metisMenu/2.5.2/metisMenu.min.css").Include(
                "~/Content/Stylesheet/metisMenu.min.css");
            bundles.Add(MetisMenuStyleBundle);

            var FontAwesomeStyleBundle = new StyleBundle("~/Content/Stylesheet/FontAwesome", "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css").Include(
                "~/Content/Stylesheet/font-awesome.min.css");
            bundles.Add(FontAwesomeStyleBundle);

            var animateStyleBundle = new StyleBundle("~/Content/Stylesheet/animate", "https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css").Include(
                "~/Content/Stylesheet/animate.min.css");
            bundles.Add(animateStyleBundle);

        }
    }
}