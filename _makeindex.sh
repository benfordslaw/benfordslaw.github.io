ROOT=$(pwd)
OUTPUT="index.html" 
> $OUTPUT
echo "<!DOCTYPE html><html><head>
    <meta charset='utf-8' />
        <title>Site Index</title>
        <link rel='stylesheet' href='style.css'>
	    <meta name='viewport' content='width=device-width, initial-scale=1.0'> 
    </head><body>
    <div id='bg'></div>" $(cat bio.txt) "<article>" >> $OUTPUT
for filepath in `find "$ROOT" -maxdepth 1 -mindepth 1 -type d`; do
  path=`basename "$filepath"`
  if [[ "$path" != *"."* ]]
  then echo "<a href="$path"><div>$path/</div></a>" >> $OUTPUT
  fi
done
echo "</article></body></html>" >> $OUTPUT
