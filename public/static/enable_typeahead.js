var stores = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 100,
  prefetch: {
    ttl: 60,
    // url points to a json file that contains an array of country names, see
    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
    url: '/store_names.json',
    // the json file contains an array of strings, but the Bloodhound
    // suggestion engine expects JavaScript objects so this converts all of
    // those strings
    filter: function(list) {
      return $.map(list, function(store) { return { name: store }; });
    }
  }
});

// kicks off the loading/processing of `local` and `prefetch`
stores.initialize();

// passing in `null` for the `options` arguments will result in the default
// options being used
$('input[name="store"]').typeahead(null, {
  name: 'store',
  displayKey: 'name',
  // `ttAdapter` wraps the suggestion engine in an adapter that
  // is compatible with the typeahead jQuery plugin
  source: stores.ttAdapter()
});

var products = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 100,
  prefetch: {
    ttl: 60,
    // url points to a json file that contains an array of country names, see
    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
    url: '/product_generic_names.json',
    // the json file contains an array of strings, but the Bloodhound
    // suggestion engine expects JavaScript objects so this converts all of
    // those strings
    filter: function(list) {
      return $.map(list, function(store) { return { name: store }; });
    }
  }
});

// kicks off the loading/processing of `local` and `prefetch`
products.initialize();

// passing in `null` for the `options` arguments will result in the default
// options being used
$('input[name="generic_name"]').typeahead(null, {
  name: 'product',
  displayKey: 'name',
  // `ttAdapter` wraps the suggestion engine in an adapter that
  // is compatible with the typeahead jQuery plugin
  source: products.ttAdapter()
});

var units = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 100,
  prefetch: {
    ttl: 60,
    // url points to a json file that contains an array of country names, see
    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
    url: '/unit_names.json',
    // the json file contains an array of strings, but the Bloodhound
    // suggestion engine expects JavaScript objects so this converts all of
    // those strings
    filter: function(list) {
      return $.map(list, function(store) { return { name: store }; });
    }
  }
});

// kicks off the loading/processing of `local` and `prefetch`
units.initialize();

// passing in `null` for the `options` arguments will result in the default
// options being used
$('input[name="quanity_unit"]').typeahead(null, {
  name: 'unit',
  displayKey: 'name',
  // `ttAdapter` wraps the suggestion engine in an adapter that
  // is compatible with the typeahead jQuery plugin
  source: units.ttAdapter()
});

var brands = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 100,
  prefetch: {
    ttl: 60,
    // url points to a json file that contains an array of country names, see
    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
    url: '/product_brand_names.json',
    // the json file contains an array of strings, but the Bloodhound
    // suggestion engine expects JavaScript objects so this converts all of
    // those strings
    filter: function(list) {
      return $.map(list, function(store) { return { name: store }; });
    }
  }
});

// kicks off the loading/processing of `local` and `prefetch`
brands.initialize();

// passing in `null` for the `options` arguments will result in the default
// options being used
$('input[name="product_brand_name"]').typeahead(null, {
  name: 'product_brand_name',
  displayKey: 'name',
  // `ttAdapter` wraps the suggestion engine in an adapter that
  // is compatible with the typeahead jQuery plugin
  source: brands.ttAdapter()
});

var locations = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 100,
  prefetch: {
    ttl: 60,
    // url points to a json file that contains an array of country names, see
    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
    url: '/location_names.json',
    // the json file contains an array of strings, but the Bloodhound
    // suggestion engine expects JavaScript objects so this converts all of
    // those strings
    filter: function(list) {
      return $.map(list, function(store) { return { name: store }; });
    }
  }
});

// kicks off the loading/processing of `local` and `prefetch`
locations.initialize();

// passing in `null` for the `options` arguments will result in the default
// options being used
$('input[name="location"]').typeahead(null, {
  name: 'location',
  displayKey: 'name',
  // `ttAdapter` wraps the suggestion engine in an adapter that
  // is compatible with the typeahead jQuery plugin
  source: locations.ttAdapter()
});
