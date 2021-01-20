ROOT=/Users/benkrummenacher/Documents/GitHub/benfordslaw.github.io/contents
HTTP="/Users/benkrummenacher/Documents/GitHub/benfordslaw.github.io/contents"
OUTPUT="index.html" 
> $OUTPUT
echo "<!DOCTYPE html><html><head>
    <meta charset='utf-8' />
    <title>Krummenacher</title>
    <style>
      body {margin:50px}
      td {vertical-align:top}
      ul {list-style-type: circle}
      a {color:black; text-decoration:none}
      a:hover {background-color:pink}
    </style>
  </head><body>
  <h1>Benjamin Ford Krummenacher</h1>
    <h3>/krumɪnɑkər/</h3>
    <p>Currently in my childhood home in St. Louis, MO. Otherwise, I stay in Pittsburgh, PA. <br>
      Studying art and biological sciences in the B.X.A. interdisciplinary program at Carnegie Mellon University.<br>
      These days I'm investigating relationships and labor because it seems like every day I'm learning how to better love and work.</p>
      <table><tr>" >> $OUTPUT
for filepath in `find "$ROOT" -maxdepth 1 -mindepth 1 -type d`; do
  path=`basename "$filepath"`
  echo "<td>$path/<ul><ul>" >> $OUTPUT
  for i in `find "$filepath" -maxdepth 6 -mindepth 1`; do
    file=`basename "$i"`
    if [[ "$file" == *"."* ]]
    then
      if [[ "$file" != ".DS_Store" ]]
        then echo "<li><a href="$file">$file</a></li>" >> $OUTPUT
      fi
    else
      echo "</ul><li>$file/</li><ul>" >> $OUTPUT
    fi
    done
   echo "</ul></ul></td>" >> $OUTPUT
done
echo "</tr></body></html>" >> $OUTPUT
