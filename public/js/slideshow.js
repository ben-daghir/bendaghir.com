/**
 * Iterator for slideshow
 * @param  {int} i     [curent index]
 * @param  {[String]} name  [name of slides]
 * @param  {[int]} range [number of images]
 * @return {[null]}       [none]
 */
function iterateImages(i, name, range) {
    if (i > range) {
        iterateImages(1, name, range);
    } else {
        var slides = document.getElementById(name);
        slides.src = "../adventure/" + name + "/" + name + i + ".jpg";
        setTimeout(function() {
            slides.style.opacity = 1;
        }, 100);
        setTimeout(function(){
            slides.style.opacity = 0;
            setTimeout(function() {
                console.log(slides);
                iterateImages(++i, name, range);
            }, 2600);
        }, 5000);
    }
}

iterateImages(Math.floor(Math.random() * 41) + 1, "finland", 41);
iterateImages(Math.floor(Math.random() * 120) + 1, "iceland", 120);
iterateImages(Math.floor(Math.random() * 7) + 1, "questival", 7);
iterateImages(Math.floor(Math.random() * 20) + 1, "pacificnw", 20);
iterateImages(Math.floor(Math.random() * 14) + 1, "canada", 14);
