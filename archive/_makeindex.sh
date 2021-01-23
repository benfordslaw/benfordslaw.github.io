ROOT=/Users/benkrummenacher/Documents/GitHub/benfordslaw.github.io/archive
HTTP="/Users/benkrummenacher/Documents/GitHub/benfordslaw.github.io/archive"
OUTPUT="index.html" 
> $OUTPUT
echo "<!DOCTYPE html><html><head>
    <meta charset='utf-8' />
    <title>Krummenacher</title>
    <style>
      h1, h3, h4, p {
        color: black;
      } 
      article {
        mix-blend-mode: difference; 
        color: green;
        column-count: 4;
        column-width: 300px
      }
      ul {list-style-type: circle}
      a {color: green; text-decoration:none}
      a:hover {background-color:black}
      .bg {
        top: 25vh;
        left: 25vw;
        width: 50vw;
        height: 50vh;
        position: fixed;
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
        z-index: -1;
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
        bg.style.position = 'fixed';
        bg.style.backgroundImage = 'url(' + imageURL + ')';
        bg.style.backgroundSize = 'contain';
        bg.style.backgroundPosition = 'center';
        bg.style.backgroundRepeat = 'no-repeat';
        bg.style.zIndex = '-1';
      }
    </script>
  </head><body>
    <div id='bg'></div>
    <h1>Benjamin Ford Krummenacher</h1>
    <h3>/krumɪnɑkər/</h3>
    <h4><ul>
      <li><a href='https://www.instagram.com/benfordslaw'>Instagram</a></li>
      <li><a href='https://www.youtube.com/channel/UCe3cwyi2O5RN2Xfuvgzi12w'>YouTube</a></li>
      <li><a href='https://github.com/benfordslaw'>GitHub</a></li>
    </ul></h4>
    <p>Currently in my childhood home in St. Louis, MO. Otherwise, I stay in Pittsburgh, PA. <br>
      Studying art and biological sciences in the B.X.A. interdisciplinary program at Carnegie Mellon University.<br>
      These days I'm investigating care and labor because it seems like every day I'm learning how to better love and work.</p>
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
          else echo "<li><a href="$href">$file</a></li>" >> $OUTPUT
          fi
      fi
    else
      echo "</ul><li>$file/</li><ul>" >> $OUTPUT
    fi
    done
   echo "</ul></ul></div>" >> $OUTPUT
done
echo "</article></body></html>" >> $OUTPUT