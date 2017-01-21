var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  entry: [
    "./web/static/css/app.scss",
    "./web/static/js/app.js",
  ],
  output: {
    path: "./priv/static",
    filename: "js/app.js",
  },


  module: {
    loaders: [{
      test: /\.jsx?$/,
      exclude: /node_modules/,
      loader: "babel",
      include: __dirname,
      query: {
        cacheDirectory: true,
        presets: ["es2015", "react"],
        plugins: ["transform-class-properties"]
      },
    }, {
      test: /\.scss$/,
      loader: ExtractTextPlugin.extract("style", "css!sass"),
    }],
  },

  resolve: {
    moduleDirectories: [ "node_modules", __dirname + "/web/static/js" ],
    extensions: ['', '.js', '.jsx'],
  },

  externals: {
    "responsivevoice": "responsiveVoice",
  },

  plugins: [
    new ExtractTextPlugin("css/app.css"),
    new CopyWebpackPlugin([{ from: "./web/static/assets" }]),
  ],
}
