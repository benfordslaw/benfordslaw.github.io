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
    bg.style.cursor = 'color';
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
