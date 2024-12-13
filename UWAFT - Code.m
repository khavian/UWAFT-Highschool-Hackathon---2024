function newArray = timeElapsed(datetime_array)
    % This function converts an array of elements in datetime format
    % into the total elapsed time in seconds since the first data point was
    % acquired
    %
    % To find out more about datetime formats and arrays try the command:
    %
    %   >> doc datetime
    %
    % Copyright 2018 The MathWorks, Inc
    
    newArray = second(datetime_array);  
    % Extracts the second component from each datetime value in the array.

    arraySize = numel(newArray); 
    % Gets the number of elements in the new array (i.e., the number of seconds).

    first = newArray(1); 
    % Stores the first element of the newArray to subtract from later.

    i = 1;
    % Initialize counter variable i.

    % The following loop will run until it reaches the end of the array.
    % Whenever the next number is smaller than the current number, the loop will
    % add 60 seconds and restart the loop to correct any time inconsistencies.
    while i < arraySize
        if newArray(i) > newArray(i + 1)
            newArray(i + 1) = newArray(i + 1) + 60;
            i = 1;  % Restart from the beginning of the array to check for time inconsistencies.
        end
        i = i + 1; 
        % Increment the counter to proceed to the next element in the array.
    end
    
    % Subtract the first number from all elements of the array in order to start
    % the array at 0, representing the time elapsed since the first data point.
    newArray = newArray - first;  
end

clear
% Clears the workspace, removing all variables, functions, and MEX-files.

load('ExampleData.mat'); 
% Loads the ExampleData.mat file, which contains data for positions and accelerations.

lat = Position.latitude; 
% Extracts the latitude data from the Position structure.

lon = Position.longitude; 
% Extracts the longitude data from the Position structure.

positionDatetime = Position.Timestamp; 
% Extracts the timestamp data associated with the position data.

Xacc = Acceleration.X; 
% Extracts the X acceleration data from the Acceleration structure.

Yacc = Acceleration.Y; 
% Extracts the Y acceleration data from the Acceleration structure.

Zacc = Acceleration.Z; 
% Extracts the Z acceleration data from the Acceleration structure.

accelDatetime = Acceleration.Timestamp; 
% Extracts the timestamp data associated with the acceleration data.

% We use the following to obtain linear time data in seconds from a datetime array
positionTime = timeElapsed(positionDatetime); 
% Converts the position timestamps into time elapsed in seconds using the timeElapsed function.

accelTime = timeElapsed(accelDatetime); 
% Converts the acceleration timestamps into time elapsed in seconds using the timeElapsed function.

earthCirc = 24901;  
% The Earth's circumference in miles, which will be used to calculate the distance traveled.

totaldis = 0;  
% Initialize the total distance variable to accumulate the total distance traveled.

% Loop to calculate total distance traveled
for i = 1:(length(lat) - 1) 
    % Loop through each pair of consecutive latitude and longitude values.
    lat1 = lat(i);  % The first latitude
    lat2 = lat(i + 1);  % The second latitude
    lon1 = lon(i);  % The first longitude
    lon2 = lon(i + 1);  % The second longitude
    
    degDis = distance(lat1, lon1, lat2, lon2);  
    % Calculates the distance between the two points in degrees using the 'distance' function.
    
    dis = (degDis / 360) * earthCirc;  
    % Converts the distance from degrees to miles based on Earth's circumference.

    totaldis = totaldis + dis;  
    % Accumulates the total distance traveled by adding the calculated distance for this segment.
end

% Convert total distance to meters
stride = 2.5;  % Average stride length in feet.
totaldis_m = totaldis * 1609.34;  % Converts the total distance from miles to meters (1 mile = 1609.34 meters).
steps = totaldis_m / stride;  % Calculates the total number of steps, using the stride length in feet.

% Display total distance in meters and kilometers
disp(['The total distance traveled is: ', num2str(totaldis_m), ' meters']);  
% Displays the total distance in meters.

totaldis_km = totaldis * 1.60934;  
% Converts the total distance from miles to kilometers (1 mile = 1.60934 km).

disp(['The total distance traveled is: ', num2str(totaldis_km), ' kilometers']);  
% Displays the total distance in kilometers.

% Plot acceleration data
figure;  
% Creates a new figure window for plotting.

plot(accelTime, Xacc);  
% Plots the X acceleration data against the elapsed time.

hold on;  
% Keeps the current plot, so that additional plots can be added to the same figure.

plot(accelTime, Yacc);  
% Plots the Y acceleration data against the elapsed time.

plot(accelTime, Zacc);  
% Plots the Z acceleration data against the elapsed time.

xlim([0 50]);  
% Sets the x-axis limits to display the first 50 seconds of data.

hold off;  
% Releases the current plot hold, so that new plots would overwrite the existing ones if added.

legend('X Acceleration', 'Y Acceleration', 'Z Acceleration');  
% Adds a legend to the plot, labeling the three acceleration components.

xlabel('Time (s)');  
% Adds a label to the x-axis, indicating the time in seconds.

ylabel('Acceleration (m/s^2)');  
% Adds a label to the y-axis, indicating acceleration in meters per second squared.

title('Acceleration Data Vs. Time');  
% Adds a title to the plot, indicating that it shows the relationship between acceleration and time.
