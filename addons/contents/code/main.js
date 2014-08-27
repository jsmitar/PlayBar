// we have access to the full API from in here as well, and can include files
// from the main addon's package as well. in this case, we load an svg from the
// addon package during construction.

// this will serve as our constructor; we will feed it later on to registerAddon
function AudioTagger()
{
    this.svg = new Svg('tiger')
}

// now let's add a little function to the prototype of our constructor
AudioTagger.prototype.toString = function()
{
    return "Get me an url"
}

AudioTagger.prototype.setUrl(url) = function()
{
	return "Get me an url"
}

AudioTagger.prototype.setRating = function(value)
{
	return url;
}



// since there is no contents/code/include.js in this addon's package,
// it will look for it in the Plasmoid's own package
plasmoid.include("include.js")

// and now we register our constructor; that's it!
registerAddon(SampleAddon)

