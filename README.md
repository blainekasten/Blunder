Blunder
=======

Another flavored markdown parser.

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
__ --> underscore tags<br> 
\n --> line break tags<br>
____ --> li tags (four spaces, tab)<br>
[a]href tag --> anchor tag (<a href="href">tag</a>)

# License

The MIT License (MIT) Copyright (c) 2013 Blaine Kasten

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
