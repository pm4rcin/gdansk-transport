FROM fedora:39

EXPOSE 8080
EXPOSE 8081

RUN sudo dnf install java-21-openjdk osmctools --assumeyes

RUN curl -LJO "https://github.com/opentripplanner/OpenTripPlanner/releases/download/v2.4.0/otp-2.4.0-shaded.jar"
RUN mv otp-2.4.0-shaded.jar otp.jar

RUN curl "https://ckan.multimediagdansk.pl/dataset/c24aa637-3619-4dc2-a171-a23eec8f2172/resource/30e783e4-2bec-4a7d-bb22-ee3e3b26ca96/download/gtfsgoogle.zip" -o gtfsgdansk.zip

RUN curl -O "https://download.geofabrik.de/europe/poland/pomorskie-latest.osm.pbf"

RUN osmconvert pomorskie-latest.osm.pbf -b=18.429495,54.274919,18.950244,54.466449 --complete-ways -o=gdansk.pbf

RUN java -Xmx2G -jar otp.jar --buildStreet .
RUN java -Xmx2G -jar otp.jar --loadStreet --save .

ENTRYPOINT java -Xmx2G -jar otp.jar --load .
