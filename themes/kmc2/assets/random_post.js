// Parses the sitemap and goes to a random post
function go_to_random_post(hyperlink) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/sitemap.xml", true);
    xhr.onload = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200 || xhr.status == 0) {
                parser = new DOMParser();
                xmlDoc = parser.parseFromString(xhr.responseText, "text/xml");

                // Obtener la lista de páginas
                pages = xmlDoc.getElementsByTagName('loc');
                while (true) {
                    random_id = Math.floor(Math.random() * pages.length);
                    url = pages[random_id].textContent;
                    if (url.indexOf("/posts/") > -1) {
                        if (url.indexOf("/more_pictures") == -1) {
                            hyperlink.setAttribute('href', url);
                            break;
                        }
                    }
                }
            }
        }
    }
    xhr.send(null);
}

document.addEventListener('DOMContentLoaded', function () {
    var hyperlink = document.getElementById("menu-random").children[0];
    go_to_random_post(hyperlink);
}, false);
