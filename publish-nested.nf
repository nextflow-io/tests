params.x = 'ciao'

process foo {
  publishDir "data", mode: 'copy', overwrite: true

  output:
    file("a")

  script:
  """
  mkdir -p a/b/c
  echo -n $params.x > a/b/c/file.txt
  """
}