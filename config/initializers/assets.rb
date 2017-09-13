# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( style.css bootstrap.css responsive.css font-awesome.min.css oauth.css oauth.js home_page.css home_page.js jquery.Jcrop.css jquery.Jcrop.js lightbox-plus-jquery.min.js jquery.Jcrop.min)
#for slider image
