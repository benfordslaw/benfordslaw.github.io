ROOT=/Users/benkrummenacher/Documents/GitHub/benfordslaw.github.io/art
HTTP="/Users/benkrummenacher/Documents/GitHub/benfordslaw.github.io/art"
OUTPUT="index.html" 
> $OUTPUT
echo "<!DOCTYPE html><html><head>
    <meta charset='utf-8' />
    <title>Selected Art</title>
    <link rel='stylesheet' href='../style.css'>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'> 
    <script>
	  function displayImage(imageURL) {
        var bg = document.getElementById('bg');
        bg.style.top = '25vh';
        bg.style.right = '10vw';
        bg.style.width = '30vw';
        bg.style.height = '50vh';
        bg.style.position = 'fixed';
        bg.style.backgroundImage = 'url(' + imageURL + ')';
        bg.style.backgroundColor = 'white';
        bg.style.backgroundSize = 'contain';
        bg.style.backgroundPosition = 'center';
        bg.style.backgroundRepeat = 'no-repeat';
        bg.style.mixBlendMode = 'multiply'; 
		bg.style.cursor = 'zoom-in';
        bg.style.zIndex = '1';
        bg.innerHTML = '';
      }
      function displayText(txtURL) {
        var bg = document.getElementById('bg');
        bg.style.overflowY = 'auto';
        bg.style.top = '25vh';
        bg.style.right = '10vw';
        bg.style.width = '30vw';
        bg.style.height = '50vh';
        bg.style.position = 'fixed';
        bg.style.backgroundImage = 'none';
        bg.style.backgroundColor = 'yellow';
        bg.style.color = 'black';
        bg.style.mixBlendMode = 'multiply';
		bg.style.cursor = 'zoom-in';
        var rawFile = new XMLHttpRequest();
        rawFile.open('GET', txtURL, false);
        rawFile.onreadystatechange = function ()
        {
            if(rawFile.readyState === 4)
            {
                if(rawFile.status === 200 || rawFile.status == 0)
                {
                    var allText = rawFile.responseText;
                    bg.innerHTML = allText;
                }
            }
        }
        rawFile.send(null);
        bg.style.zIndex = '1';
      }
      var full = false;
  	  function toggleBG() {
		if (!full) {
          bg.style.top = '10vh';
		  bg.style.right = '10vw';
		  bg.style.width = '80vw';
		  bg.style.height = '80vh';
		  full = true;
		  bg.style.cursor = 'zoom-out';
		}
	    else {
		  bg.style.top = '25vh';
		  bg.style.right = '10vw';
		  bg.style.width = '30vw';
		  bg.style.height = '50vh';
		  full = false;
		  bg.style.cursor = 'zoom-in';
		}
      }
    </script>
  </head><body>
  <div id='bg' onclick='toggleBG()'></div>" $(cat ../bio.txt) "<article>" >> $OUTPUT
for filepath in `find "$ROOT" -maxdepth 1 -mindepth 1 -type d`; do
  path=`basename "$filepath"`
  echo "<div>$path/<ul><ul>" >> $OUTPUT
  for i in `find "$filepath" -maxdepth 6 -mindepth 1 -print0 | sort -z | xargs -r0`; do
    file=`basename "$i"`
    if [[ "$file" == *"."* ]]
    then
      if [[ "$file" != ".DS_Store" ]]
        then 
          href=${i#*$"github.io"}
          if [[ "${href#*$'.jpg'}" == "" ]] || [[ "${href#*$'.jpeg'}" == "" ]] || [[ "${href#*$'.JPG'}" == "" ]] || [[ "${href#*$'.gif'}" == "" ]] || [[ "${href#*$'.png'}" == "" ]]
          then echo "<li><a onclick='displayImage(\""$href"\")'>$file</a></li>" >> $OUTPUT
          elif [[ "${href#*$'.txt'}" == "" ]]
		  then echo "<li><a onclick='displayText(\""$href"\")' style='color:magenta'>$file</a></li>" >> $OUTPUT
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
