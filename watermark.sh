savedir=".originals"
#mkdir $savedir

if [ $? -ne 0 ] ; then
  echo "Error: failed making $savedir."
  exit 1
fi

for image in *png *jpg *JPG *gif
do
 if [ -s $image ] ; then   # non-zero file size
    width=$(identify -format %w $image)
##    convert -background '#0000' -fill white -gravity southeast \
##       -font Andale-Mono -pointsize 24 label:WATERMARK TEXT \
##       -size ${width}x100 \ #caption:WATERMARK TEXT \
##       $image +swap -gravity south -composite new-$image
    convert -background '#0008' -font Andale-Mono -pointsize 128 -fill white label:'WATERMARK TEXT' miff:- |\
        composite -gravity southeast -geometry +0+3 \
        - $image new-$image
     #mv $image $savedir
     mv new-$image $image
    echo "watermarked $image successfully"
  fi
done
