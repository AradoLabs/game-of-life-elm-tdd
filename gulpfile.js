var gulp = require('gulp')
var shell = require('gulp-shell')
var console = require('better-console')

gulp.task('build-tests', shell.task([
  'elm-make --warn ./src/TestRunner.elm --output test.js'
]))

gulp.task('run-tests', ['build-tests'], shell.task([
  'clear',
  'node test.js'
]))

gulp.task('test', function () {
  gulp.run('run-tests')

  gulp.watch(['src/**/*.elm'], ['run-tests'])
})