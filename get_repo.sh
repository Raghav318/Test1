git clone https://github.com/ajiteshsharma90/RRR.git
#cp -r * s3://testingproject1010/Raghav

bucket=testingprooject1010
files_location=$pwd
now_time=$(date +"%H%M%S")
contentType="application/x-compressed-tar"
dateValue=`date -R`
# your key goes here..
s3Key=AKIAU5XGNFAPXWV3N2KH
# your secrets goes here..
s3Secret=ioQQ9sz+TBS49LNRpL2REHDJzf7kyzE8F39pxlHq

function pushToS3()
{
  files_path=$1
  for file in $files_path*
  do
    fname=$(basename $file)
    logInfo "Start sending $fname to S3"
    resource="/${bucket}/${now_date}/${fname}_${now_time}"
    stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
    signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
    curl -X PUT -T "${file}" \
     -H "Host: ${bucket}.s3.amazonaws.com" \
     -H "Date: ${dateValue}" \
     -H "Content-Type: ${contentType}" \
     -H "Authorization: AWS ${s3Key}:${signature}" \
      https://${bucket}.s3.amazonaws.com/${now_date}/${fname}_${now_time}
     logInfo "$fname has been sent to S3 successfully."
  done
}
pushToS3 $files_location
