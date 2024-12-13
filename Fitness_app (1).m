clear %clears the results of the prevous code
load('ExampleData.mat'); %loads the data of the example file
lat=Position.latitude; %Defines the varible, Lat(varible name) is equal to the position of the latitude
lon=Position.longitude; %Defines another varible, Lon is equal the the value of the position of the longitude
positionDatetime=Position.Timestamp; %PositionDatetime(another varible) is equal to positon.timestamp
%position.timestamp is used to find value of the position is based off of
%the timestamp, for example, if the position of x is going up by 2 every
%second and starts at 0, then the timestamp of the postion would be 2 for
%the timestamp of 1 second and the value would be 6 at a timestamp of 3
%seconds
Xacc = Acceleration.X; %Defining a varible to refrence the accelration of x
Yacc = Acceleration.Y; %Defining a varible to refrence the accelration of y
Zacc = Acceleration.Z; %Defining a varible to refrence the accelration of z

accelDatetime=Acceleration.Timestamp; % We use the following to obtain linear time data in seconds from a datetime array
positionTime = timeElapsed(positionDatetime); %makes the position time equal to the total time the program has had multipled by position time
accelTime = timeElapsed(accelDatetime); %Makes Accel time equal to the total time multiplied by the acceleration time
earthCirc = 24901; %The circumference of the earth
totaldis = 0; %Variable for the total distence
for i = 1:(length(lat)-1) %Length multiplied by latitude then subtract the answer by 1
lat1 = lat(i); % The first latitude 
lat2 = lat(i+1); % The second latitude
lon1 = lon(i); % The first longitude
lon2 = lon(i+1); % The second longitude
 degDis = distance(lat1, lon1, lat2, lon2); %Distance multiplied by both latitudes and both lon
 dis = (degDis/360)*earthCirc; %Degree distance divided by 360, then multiple the answer by earth circumference
 totaldis = totaldis + dis; % total distence plus distence
end % ends the events starting from the for event on line 23
stride = 2.5; % Average stride (ft)
totaldis_ft = totaldis*5280; % Converting distance from miles to feet
steps = totaldis_ft/stride; %Steps is equal to the total distence in feet divided by the stride
disp(['The total distance traveled is: ', num2str(totaldis),' miles']) %gives the total distance 
disp(['You took ', num2str(steps) ' steps']) %Shows how many steps you took
plot(accelTime,Xacc);%Plots points on the graph using the acceleration and the acceleration of each variable
hold on;
plot(accelTime,Yacc); 
plot(accelTime,Zacc);
xlim([0 50]) %makes it so it is only the first 50 seconds of data so its easier to look at and understand
legend('X Acceleration','Y Acceleration','Z Aceeleration'); %shows each line in a legend on the top
xlabel('Time (s)') %makes a line on bottom to show the time 
ylabel('Acceleration (m/s^2)'); %shows the acceleration on the side
title('Acceleration Data Vs. Time'); %makes a title on top that shows that the graph data repesents acceleration vs time
hold off %Ends the loop for the making the graph

