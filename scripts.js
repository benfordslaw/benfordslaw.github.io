let idx_shown = 0;

document.addEventListener('keydown', (event) => {
    if (event.keyCode == 74 || event.keyCode == 40) {
        num_links = Array.from(document.querySelectorAll("a")).length;
        idx_shown = (idx_shown + 1) % num_links;
    }
    if (event.keyCode == 75 || event.keyCode == 38) {
        idx_shown = (idx_shown - 1) % num_links;
    }
    display_from_key();
}, false);
function update_links(imageURL) {
    for (const a of document.querySelectorAll("a")) {
        if (a.hasAttribute('onclick')) {
            if (a.getAttribute('onclick').includes(imageURL)) {
                a.style.backgroundColor = 'yellow';
                idx_shown = Array.from(document.querySelectorAll("a")).indexOf(a);
            } else {
                a.style.backgroundColor = '';
            }
        }
    }
}
function display_from_key() {
    var url = Array.from(document.querySelectorAll("a"))[idx_shown].getAttribute('onclick').split('"')[1];
    if (url.includes(".txt")) {
        displayText(url);
    } else {
        displayImage(url);
    }
}
function displayImage(imageURL) {
    var bg = document.getElementById('bg');
    bg.style.top = '25vh';
    bg.style.right = '10vw';
    bg.style.width = '30vw';
    bg.style.height = '50vh';
    bg.style.position = 'fixed';
    bg.style.backgroundImage = 'url(' + imageURL + ')';
    bg.style.backgroundColor = 'transparent';
    bg.style.backgroundSize = 'contain';
    bg.style.backgroundPosition = 'center';
    bg.style.backgroundRepeat = 'no-repeat';
    bg.style.mixBlendMode = 'normal'; 
    bg.style.cursor = 'color';
    bg.style.zIndex = '1';
    bg.innerHTML = '';
    update_links(imageURL);
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
    bg.style.mixBlendMode = 'normal';
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
    update_links(txtURL);
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
