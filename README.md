# rasen
PHP blogging MVC.

# INSTALL

Upload lumizone.sql to a mysql database (phpmyadmin) under the db name luminal_zone. Sessions and url rerouting need to be turned on in php.ini, but they usually are by default.

-----

# TEMPLATES

Templates The site works through the 404 page by dynamically checking /lib/tpl/ for a folder that corresponds with the current url. If you're on /home/, it'll look for a file existing at /lib/tpl/home/home.tpl so you can easilly add new pages to the website. It's a custom 404/url router. Files must end in either .php or .tpl (template file).

WARNING: If you name posts as reserved url routing names, they WILL be replaced. You could replace the 404 page this way if you want it to link to a post instead if you wanted to.
/404/, /admin/, /archive/, /feed/, /home/, /license/, /dimtreeline/, /logout/, /rasen/ and /registry/ are all reserved.

The url routing is fully modular, so templates may also be removed and they will then return a 404.

-----

# ADMIN

LOGIN PAGE: /dimtreeline/
USERNAME: admin
PASSWORD: password

The site is blank by default, so you have to populate the registry and archive, change your login/username, and update your password and provide a new avatar.

[ + new post + ] in the admin panel scrolls out the form, and you can only upload 4 files to a post.

Pages are automatically sorted in /feed/, if you upload an image to a post, then it will show in /feed/art/. If you upload a zip it'll show up in /games/, audio to /music/. Plaintext posts with no file upload will be in /blog/. You can include extra images to a post by uploading them in /admin/upload/ and embedding them with (img) tags, but if no file is attached to the post directly it'll show up in /feed/blog/.

If you want to edit the registry, license or the archive pages, you can do so in the /pages/ tab in the admin panel. Page editing directly edits template files.

Hidden posts don't show up in the feed but you can link them directly.

You can use bbcode in posts, so far I just have b, i, u, center and img tags you do like (img)link(/img), you use square brackets for bbcode.

You cannot edit uploaded files in posts, you must delete and repost.

To change your password, go to /admin/settings/ and change it there. There aren't any emails yet cus I don't know how to do that without a website already being hosted.

Edit and delete buttons are to the top right of posts, they only appear if you're logged in.
