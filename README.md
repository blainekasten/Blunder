Blunder
=======

Another text markup parser.

It's syntax is as follows:

<code>^Bold Text^</code> parses into -> <code><b>Bold Text</b></code>

<code>~Italic Text~</code> parses into -> <code><i>Italic Text</i></code>

<code>_Underscore Text_</code> parses into -> <code><u>Underscore Text</u></code>

How to use!
===

Include the script on your page, and create a parser.

<code>
    blunderParser = new Blunder
</code>

Then you can feed the parser blundered markup to convert into html:<br>
<code>
      blunderParser.parseText("^Bold ~Stuff~^")
</code> --> <code><b>Bold <i>Stuff</i></b></code>

You can also do the opposite, feeding the parser html and getting Blundered markup:
      
<code>
      blunderParser.reverseParse("<b>Bold <i>Stuff</i></b>")
</code> --> <code>"^Bold ~Stuff~^"</code>

Here is the current list of elements that can convert:<br>
^ --> bold tags<br>
~ --> italic tags<br>
_ --> underscore tags<br>
\n --> line break tags
