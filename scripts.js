let idx_shown = 0;
var full = false;

document.addEventListener('click', function(){
    clearInterval(cycle_img);
});
window.onload = (event) => {
    idx_shown = Math.floor(Math.random() * Array.from(document.querySelectorAll("article a")).length);
    display_from_key();
}

var cycle_img = window.setInterval(function(){
    idx_shown = Math.floor(Math.random() * Array.from(document.querySelectorAll("article a")).length);
    display_from_key();
}, 2500);

document.addEventListener('keydown', (event) => {
    clearInterval(cycle_img);
    num_links = Array.from(document.querySelectorAll("article a")).length;
    if (event.keyCode == 74 || event.keyCode == 40) {
        idx_shown = (idx_shown + 1) % num_links;
        display_from_key();
    } else if (event.keyCode == 75 || event.keyCode == 38) {
        idx_shown = (((idx_shown - 1) % num_links) + num_links) % num_links;
        display_from_key();
    } else if (event.keyCode == 32 || event.keyCode == 13) {
        toggleBG();
    } }, false);
function update_links(imageURL) {
    for (const a of document.querySelectorAll("article a")) {
        if (a.getAttribute('onclick').includes(imageURL)) {
            a.style.backgroundColor = 'yellow';
            idx_shown = Array.from(document.querySelectorAll("article a")).indexOf(a);
        } else {
            a.style.backgroundColor = '';
        }
    }
}
function display_from_key() {
    var url = Array.from(document.querySelectorAll("article a"))[idx_shown].getAttribute('onclick').split('"')[1];
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
    for (const a of document.querySelectorAll("article a")) {
        if (a.getAttribute('onclick').includes(imageURL)) {
            for ( const a_2 of a.parentNode.children ) {
                if (a_2.innerHTML.includes(".txt")){
                    txtURL = a_2.getAttribute('onclick').split('"')[1];
                    caption = document.getElementById('caption');
                    var rawFile = new XMLHttpRequest();
                    rawFile.open('GET', txtURL, false);
                    rawFile.onreadystatechange = function ()
                    {
                        if(rawFile.readyState === 4)
                        {
                            if(rawFile.status === 200 || rawFile.status == 0)
                            {
                                var allText = rawFile.responseText;
                                caption.innerHTML = allText;
                            }
                        }
                    }
                    rawFile.send(null);
                }
            }
        }
    }
    update_links(imageURL);
    full = false;
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
    full = false;
}
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
