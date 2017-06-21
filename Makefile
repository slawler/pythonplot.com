
OUTPUTDIR=web

S3_BUCKET=pythonplot.com

all: render s3_upload
	echo "Done"

travis: run_nb render
	echo "Done"

render:
	python render.py

s3_upload:
	s3cmd sync $(OUTPUTDIR)/ s3://$(S3_BUCKET) --acl-public --delete-removed --guess-mime-type --no-mime-magic --no-preserve

run_nb:
	jupyter nbconvert --to notebook --execute "ggplot vs Python Plotting.ipynb" --output "ggplot vs Python Plotting.ipynb"

.PHONY: all render s3_upload run_nb travis