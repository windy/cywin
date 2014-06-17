#!/bin/sh
mkdir tmp
cd tmp
wget https://github.com/sunspot/sunspot/archive/v2.0.0.pre.130115.zip
unzip v2.0.0.pre.130115.zip
mv sunspot-2.0.0.pre.130115 sunspot
wget http://mmseg4j.googlecode.com/files/mmseg4j-1.8.5.zip
unzip mmseg4j-1.8.5.zip -d mmseg4j
cp -rf sunspot/sunspot_solr/solr ../sunspot_solr_mmseg4j
mkdir -p WEB-INF/lib
cp mmseg4j/dist/*-1.8.5.jar WEB-INF/lib
cp mmseg4j/data/ ../sunspot_solr_mmseg4j/solr/mmseg4j_dict/ -r
sed 's,class="solr.StandardTokenizerFactory",class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="max-word" dicPath="mmseg4j_dict",g' -i ../sunspot_solr_mmseg4j/solr/conf/schema.xml
zip -u ../sunspot_solr_mmseg4j/webapps/solr.war WEB-INF/lib/*.jar
cd ..
rm -rf tmp
echo "******************"
echo "** install done **"
echo "******************"
echo "cd sunspot_solr_mmseg4j and run 'java -jar start.jar' to start jetty"
echo "visit http://localhost:8983/solr/ to verify result"
