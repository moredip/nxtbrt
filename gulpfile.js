var gulp = require('gulp'),
    plumber = require('gulp-plumber'),
    coffee = require('gulp-coffee'),
    sourcemaps = require('gulp-sourcemaps'),
    download = require('gulp-download'),
    concat = require('gulp-concat'),
    rename = require('gulp-rename'),
    inject = require('gulp-inject'),
    del = require('del'),
    bartStations = require('./gulp/bart-stations');


gulp.task('clean', function (cb) {
  del(['public'],cb);
});

gulp.task('coffee', function () {
    gulp.src('coffee/*.coffee')
    .pipe(plumber())
    //.pipe(sourcemaps.init())
    .pipe(coffee())
    .pipe(concat('app.js'))
    //.pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('public'));
});

gulp.task('copy', function () {
  var inputs = [
    'css/*.css',
    'node_modules/jquery/dist/jquery.*',
    'node_modules/q/q.js'
  ];
  gulp.src(inputs)
    .pipe(gulp.dest('public'));
});

gulp.task('stations', function () {
  download("http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V")
    .pipe(bartStations())
    .pipe(rename('stations.json'))
    .pipe(gulp.dest('public'));
});

gulp.task('injected-index', function () {
  var stationsJson = download("http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V")
    .pipe(bartStations());

  var injector = inject(stationsJson,{
    starttag: '/*_inject:stations_*/',
    endtag: '/*_endinject_*/',
    transform: function (filePath, file) {
      return "STATIONS: "+file.contents.toString('utf8')
    }
  });

  gulp.src('index.html')
    .pipe(injector)
    .pipe(gulp.dest('public'));
});

gulp.task('default', ['injected-index','coffee','copy']);

gulp.task('watch', ['default'], function(){
  gulp.watch(['css/*.css'], ['copy']);
  gulp.watch(['coffee/*.coffee'], ['coffee']);
});
