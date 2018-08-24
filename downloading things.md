# Downloading Pictures from net for reasons.

##get images
```sh
for i in {1..200}; do wget <url>/$i.jpg; done;
```

##adding leadin zeros
```sh
for a in [0-9]*.jpg; do mv $a `printf %03d.%s ${a%.*} ${a##*.}`; done;
```

another way to add leading zeros
```sh
for i in ch.*;do mv $i `printf '%04d\n' ${i//[!0-9]/}`; done
```

##converting into cbr format
```sh
rar a -r ../<archive name>.cbr ./*
```

