String.prototype.splice = (index, rem, string) ->
        @.slice(0, index) + string + @.slice(index + Math.abs(rem))

String.prototype.indexByRegex = (regex) ->
        indexOf = @.search(regex)

class window.Blunder

        #
        # reverseParse: (text) ->
        # @param text is the string which converts html elements into ~^_,etc
        #
        reverseParse: (text) ->
                text = @_replaceExpr(/(<b>|<\/b>)/, text, "^")          #Bold
                text = @_replaceExpr(/(<i>|<\/i>)/, text, "~")          #Italic
                text = @_replaceExpr(/(<u>|<\/u>)/, text, "__")         #Underline
                text = @_replaceExpr(/<br\/>/, text, "\n")              #Line breaks
                text = @_replaceExpr(/<li>/, text, "    ")              #list
                text = @_replaceLink(/'(.*?)'/, />(.*?)<\/a>/, text)    #anchor
       
        #
        # parseText: (text) ->
        # @param text is the string to convert ~^_,etc into html elements
        #
        parseText: (text) ->
                text = @_parseLink(/\[a\]\S*/, /\s(.+)/,  text)              #anchor
                text = @_parseExpr(/\^/, text, "<b>")                           #Bold
                text = @_parseExpr(/\~/, text, "<i>")                           #Italics
                text = @_parseExpr(/\_\_/, text, "<u>")                           #Underlines
                text = @_parseExpr(/\n/, text, "<br/>", false)                  #line breaks
                text = @_parseExpr(/\s\s\s\s/, text, "<li>", false, true)       #list

        #
        ## Private Methods used to do the actual replacements
        #
        
        _parseExpr: (expr, text, tag, closeTag = true, closeOnReturn = false) ->
                clTag = tag.splice(1,0,"/")
                if expr.test text 
                        text = text.replace(expr, tag)
                        text = text.replace(expr, clTag) unless closeTag is false
                        text = text.replace(/\n/, clTag) if closeOnReturn is true
                        @_parseExpr(expr, text, tag, closeTag, closeOnReturn) #Cycle back through until the test stops us
                else text

        _parseLink: (linkExpr, tagExpr, text) ->
                #test starts passing when a string matches [a]text tag\r
                fullExpr = /\[a\].*.\s\w.*/
                if fullExpr.test text
                        fullCatch = text.match(fullExpr)
                        if text.match(linkExpr) is null
                                return
                        else
                                linkCatch = text.match(linkExpr)
                        linkTag = fullCatch[0].match(tagExpr)[1]
                        linkHref = linkCatch[0].substring(3)

                        tag = "<a href='#{linkHref}'>#{linkTag}</a><br/>"

                        text = text.replace(fullExpr, tag)
                        @_parseLink(linkExpr, tagExpr, text)
                else text
        
        _replaceExpr: (expr, text, mark) ->
                if expr.test text
                        text = text.replace(expr, mark)
                        @_replaceExpr(expr, text, mark)
                else text

        _replaceLink: (linkExpr, titleExpr, text) ->
                if titleExpr.test text
                        href = text.match(linkExpr)[1]
                        title = text.match(titleExpr)[1]

                        mark = "[a]#{href} #{title}"
                        text = text.replace(/(<a href=.*<\/a>)/, mark)
                        @_replaceLink(linkExpr, titleExpr, text)
                else text

