ROOT=$(pwd)
OUTPUT="index.html" 
> $OUTPUT
echo "<!DOCTYPE html><html><head>
    <meta charset='utf-8' />
    <title>Selected Art</title>
    <link rel='stylesheet' href='../style.css'>
    <script src="../scripts.js"></script>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'> 
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
