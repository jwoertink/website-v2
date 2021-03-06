class Guides::Frontend::AssetHandling < GuideAction
  guide_route "/frontend/asset-handling"

  def self.title
    "Asset Handling"
  end

  def markdown
    <<-MD
    ## Asset handling with Webpack and Laravel Mix

    By default Lucky comes set up with asset handling using Webpack through
    [Laravel Mix](https://www.npmjs.com/package/laravel-mix). Laravel Mix is a wrapper
    for common Webpack functionality that makes configuring Webpack much simpler.

    ## Why Laravel Mix instead of plain Webpack?

    Lucky uses Laravel Mix because it is very simple to configure, it's fast, and
    it works well for a lot of apps. It is also has methods for configuring
    webpack as you normally would so you have the full power of Webpack when you
    need something more complex.

    For a lot of people the default Laravel Mix setup will work out of the box, or with
    little configuration.

    ## Configuring Webpack

    There is a `webpack.mix.js` file in your project root. You can modify this to
    set up React, change your entry points, etc.

    Check out the [Laravel Mix documentation](https://github.com/JeffreyWay/laravel-mix/tree/master/docs#summary)
    for more examples of what you can do.

    ## Structuring your JavaScript

    Babel is set up so you can use new features of JavaScript.

    The entry point for JavaScript is `src/js/app.js`. You'll see that by default
    it imports Turbolinks for fast page rendering and RailsUjs to handle AJAX, links
    with PUT and DELETE requests, and a few other things. Check the
    [Turbolinks](https://github.com/turbolinks/turbolinks) and
    [RailsUjs](https://github.com/rails/jquery-ujs/wiki) docs for more info.

    Note that *RailsUjs is required* if you are rendering HTML pages in Lucky. If
    you remove it, PUT and DELETE links will no longer work correctly. You can
    safely remove Turoblinks without any problems if you don't want to use it.

    To add new JavaScript add files to `src/js/{filename}` and import them in `src/js/app.js`

    ## Structuring your CSS

    The main css file is `src/css/app.scss` and is rendered using SASS.
    Laravel Mix also sets up autoprefixer so your styles automatically have
    vendor prefixes.

    You can import other files by putting them in `src/css/*`, and importing
    them from `app.scss`. For example, you might put a component in
    `src/css/components/_btn.scss`. Remember to end the file with `.scss` so
    it's imported correctly.

    Lucky comes with some helpful plugins to make CSS a pleasure to write:

    * [Lost grid system](http://lostgrid.org) for easily writing grids
    * [Normalize.css](https://necolas.github.io/normalize.css/) for making styles consistent

    ## Removing unwanted packages

    Lucky comes with a few JavaScript and CSS packages by default. If you want to
    remove the ones you don't want, run `yarn remove {package_name}`.

    If it is a CSS or JavaScript package you may also need to remove the imports from
    `src/css/app.css` or `src/js/app.js`.

    ## Images, fonts and other assets

    You can put images, fonts and other assets in the `public/assets` folder.

    By default there is a `public/assets/images` folder, but you can add more, such
    as: `fonts`, `pdfs`, etc.

    ### Background images in CSS

    Webpack is set up to ensure your background images are present and
    fingerprinted. To have Webpack check your background images and make sure
    they are ready for caching, make sure to use relative URLs:

    ```sass
    // Webpack will find the image and rewrite the URL
    background: url("../public/assets/images/my-background.jpg")

    // Webpack will not do anything special because the path is not relative
    background: url("/images/my-background.jpg")
    ```

    ## Loading assets

    You can get a path to your assets by using the `asset` helper in pages.

    ```crystal
    # Use this in a page or component
    # Will find the asset in public/assets/images/logo.png
    img src: asset("images/logo.png")
    ```

    Note that assets are checked at compile time so if it is not found, Lucky will
    let you know. It will also let you know if you had a typo and suggest an asset
    that is close to what you typed.

    ## Automatic reloading

    Lucky comes with [Browsersync](https://www.browsersync.io) hooked up. When you
    run `lucky dev` Browsersync will open a tab and automatically reload styles and
    JavaScript for you. When you change any application files the browser will
    reload once compilation has been successful.

    You can customize Browsersync in the `bs-config.js` file. You can see a list of
    [options for Browsersync](https://browsersync.io/docs/options).

    ## Asset fingerprinting

    Fingerprinting means that every asset has a special string of characters
    appended to the filename so that the browser can cache the file safely. When an
    asset changes, the fingerprint changes and the browser will use the new version.

    Make sure to use the `asset` macro to get fingerprinted assets.

    ## Deploying to production

    If you deploy to Heroku, then you won't need to do anything. Lucky is already
    set up to build assets in production.

    If deploying outside Heroku, make sure to run `yarn prod` *before* compiling
    your project.
    MD
  end
end
