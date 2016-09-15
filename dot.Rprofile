# .First <- function() cat("\n  reading .Rprofile in Home Directory!\n\n")
# .last <- function () if (interactive()) try (savehistory (".Rhistory"))

options(repos="http://cran.ism.ac.jp")
# options(repos="http://cran.md.tuskuba.ac.jp")
# options(editor = "gedit")

# options(error = "recover")

# grDevices::X11.options(type= "cairo")
grDevices::ps.options(family= "Japan1")#
grDevices::pdf.options(family= "Japan1", bg = "white")#



setHook(packageEvent("grDevices", "onLoad"),
    function(...){
        if(.Platform$OS.type == "windows")
            grDevices::windowsFonts(sans ="MS Gothic",
                                    serif="MS Mincho",
                                    mono ="FixedFont")
        if(capabilities("aqua"))
            grDevices::quartzFonts(
              sans =grDevices::quartzFont(
                c("Hiragino Kaku Gothic Pro W3",
                  "Hiragino Kaku Gothic Pro W6",
                  "Hiragino Kaku Gothic Pro W3",
                  "Hiragino Kaku Gothic Pro W6")),
              serif=grDevices::quartzFont(
                c("Hiragino Mincho Pro W3",
                  "Hiragino Mincho Pro W6",
                  "Hiragino Mincho Pro W3",
                   "Hiragino Mincho Pro W6")))
        ## if (capabilities("cairo")){
        ##   require (Cairo)
        ##   CairoFonts (## fc-list
        ##     regular="IPA P明朝,IPAPMincho:style=Regular",
        ##     bold="IPA Pゴシック,IPAPGothic:style=Regular,Bold",
        ##     italic="IPA P明朝,IPAPMincho:style=Regular,Italic",
        ##     bolditalic="IPA Pゴシック,IPAPGothic:style=Regular,Bold Italic,BoldItalic"
        ##     )
        ## }
        if(capabilities("X11"))## xlsfonts  | grep gothic ## xfontsel
            grDevices::X11.options(
                fonts=c(
                  # "-kochi-gothic-%s-%s-*-*-%d-*-*-*-*-*-*-*",
                  #      "-adobe-symbol-medium-r-*-*-%d-*-*-*-*-*-*-*"
                  #"-ipagothic-gothic-%s-%s-normal--%d-*-*-*-*-*-*-*",
                  "-alias-gothic-%s-%s-*-*-%d-*-*-*-*-*-*-*",
                  # "-fixed-*-*-*-*-*-*-*-*-*-*-*-*",
                  "-adobe-symbol-medium-r-*-*-%d-*-*-*-*-*-*-*"
                  ))
        grDevices::pdf.options(family="Japan1GothicBBB",  bg = "white")
        grDevices::ps.options(family="Japan1GothicBBB",  bg = "white")
        }
)

attach(NULL, name = "JapanEnv")
assign("familyset_hook",
       function() {
            winfontdevs=c("windows","win.metafile",
                          "png","bmp","jpeg","tiff","RStudio")
            macfontdevs=c("quartz","quartz_off_screen","RStudio")
            devname=strsplit(names(dev.cur()),":")[[1L]][1]
            # if (capabilities("X11")) par(bg = "white")
            if ((.Platform$OS.type == "windows") &&
                (devname %in% winfontdevs))
                    par(family="sans")
            if (capabilities("aqua") &&
                devname %in% macfontdevs)
                    par(family="sans")
       },
       pos="JapanEnv")
setHook("plot.new", get("familyset_hook", pos="JapanEnv"))
setHook("persp", get("familyset_hook", pos="JapanEnv"))

