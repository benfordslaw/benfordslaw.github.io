ROOT=/Users/benkrummenacher/Documents/GitHub/benfordslaw.github.io/archive
HTTP="/Users/benkrummenacher/Documents/GitHub/benfordslaw.github.io/archive"
OUTPUT="index.html" 
> $OUTPUT
echo "<!DOCTYPE html><html><head>
    <meta charset='utf-8' />
    <title>Krummenacher</title>
    <style>
      table {margin:50px; padding: 10px}
      td {vertical-align:top}
      ul {list-style-type: circle; mix-blend-mode: screen}
      a {color:black; text-decoration:none}
      a:hover {background-color:pink}
      article {
        column-count: 4;
        column-width: 300px;
      }
    </style>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'> 
    <script>
      function displayImage(imageURL) {
        var bg = document.getElementById('bg');
        bg.style.top = '25vh';
        bg.style.left = '25vw';
        bg.style.width = '50vw';
        bg.style.height = '50vh';
        bg.style.position = 'absolute';
        bg.style.backgroundImage = 'url(' + imageURL + ')';
        bg.style.backgroundSize = 'contain';
        bg.style.backgroundPosition = 'center';
        bg.style.backgroundRepeat = 'no-repeat';
        bg.style.zIndex = '-1';
      }
    </script>
  </head><body id='body'>
  <div id='bg'></div>
  <h1>Benjamin Ford Krummenacher</h1>
    <h3>/krumɪnɑkər/</h3>
    <p>Currently in my childhood home in St. Louis, MO. Otherwise, I stay in Pittsburgh, PA. <br>
      Studying art and biological sciences in the B.X.A. interdisciplinary program at Carnegie Mellon University.<br>
      These days I'm investigating relationships and labor because it seems like every day I'm learning how to better love and work.</p>
      <article>" >> $OUTPUT
for filepath in `find "$ROOT" -maxdepth 1 -mindepth 1 -type d`; do
  path=`basename "$filepath"`
  echo "<div>$path/<ul><ul>" >> $OUTPUT
  for i in `find "$filepath" -maxdepth 6 -mindepth 1`; do
    file=`basename "$i"`
    if [[ "$file" == *"."* ]]
    then
      if [[ "$file" != ".DS_Store" ]]
        then 
          href=${i#*$"github.io"}
          if [[ "${href#*$'.jpg'}" == "" ]] || [[ "${href#*$'.JPG'}" == "" ]] || [[ "${href#*$'.png'}" == "" ]] 
          then echo "<li><a onclick='displayImage(\""$href"\")' onmouseover='displayImage(\""$href"\")'>$file</a></li>" >> $OUTPUT
          else 
          echo "<li><a href="$href">$file</a></li>" >> $OUTPUT
          fi
      fi
    else
      echo "</ul><li>$file/</li><ul>" >> $OUTPUT
    fi
    done
   echo "</ul></ul></div>" >> $OUTPUT
done
echo "</article></body></html>" >> $OUTPUT