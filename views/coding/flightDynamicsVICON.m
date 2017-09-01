function [flightDynamics] = flightDynamicsVICON(fileName)
fh = fopen(fileName);
line = fgetl(fh);

%%Structure for Data
flightDynamics = struct('hover',[],'straight',[],'turn',[]);

timeData = [];
xData = [];
yData = [];
zData = [];
phiData = [];
thetaData = [];
psiData = [];
time = 0;

while ischar(line)
    [time, rest] = strtok(line);
    time = str2num(time);
    if isempty(time)
        time = 0;
    end
    [x, rest] = strtok(rest);
    x = str2num(x);
    [y, rest] = strtok(rest);
    y = str2num(y);
    [z, rest] = strtok(rest);
    z = str2num(z);
    [phi, rest] = strtok(rest);
    phi = str2num(phi);
    [theta, rest] = strtok(rest);
    theta = str2num(theta);
    [psi, ~] = strtok(rest);
    psi = str2num(psi);
    if x ~= 0 & y ~= 0 & z ~= 0 & phi ~= 0 & theta ~= 0 & psi ~= 0
        %%Store data if it is not 0
        timeData = [timeData time];
        xData = [xData, x];
        yData = [yData, y];
        zData = [zData z];
        phiData = [phi, phiData];
        thetaData = [thetaData, theta];
        psiData = [psiData, psi];
    end
    line = fgetl(fh);    
end

%%Only hover points
hoverMask = timeData<=16 & timeData>=11;
xHover = xData(hoverMask);
yHover = yData(hoverMask);
zHover = zData(hoverMask);
phiHover = phiData(hoverMask);
thetaHover = thetaData(hoverMask);
psiHover = thetaData(hoverMask);
hoverXSD = std2(xHover);
hoverYSD = std2(yHover);
hoverZSD = std2(zHover);
hoverPhiSD= std2(phiHover);
hoverThetaSD = std2(thetaHover);
hoverPsiSD = std2(psiHover);
flightDynamics.hover = [{'x';hoverXSD}, {'y';hoverYSD}, {'z';hoverZSD}, {'phi';hoverPhiSD}, {'theta';hoverThetaSD}, {'psi';hoverPsiSD}];

figure;
plot3(xHover,yHover,zHover,'-r', 'LineWidth', 3);
title('Hovering');
xlabel('X-Position in mm');
ylabel('Y-Position in mm');
zlabel('Z-Position in mm');

%%Straight Flight
straightMask = timeData<=22 & timeData>=18;
timeStraight = timeData(straightMask);
xStraight = xData(straightMask);
yStraight = yData(straightMask);
zStraight = zData(straightMask);

%%Velocity Calcuation
velocity = sqrt(xStraight.^2+yStraight.^2+zStraight.^2);

figure;
plot3(xStraight,yStraight,zStraight,'-b', 'LineWidth', 3)
title('Forward Flight');
xlabel('X-Position in mm');
ylabel('Y-Position in mm');
zlabel('Z-Position in mm');

figure;
plot(timeStraight, velocity, '-c', 'LineWidth', 3)
title('Velocity vs Time');
xlabel('Time in seconds');
ylabel('Velocity in cm/s');

flightDynamics.straight = {'Max Velocity', max(velocity)};

%%Turning and Yaw Rate
turnMask = timeData<=53 & timeData>=47;
xTurn = xData(turnMask);
yTurn = yData(turnMask);
zTurn = zData(turnMask);

figure;
plot3(xTurn, yTurn, zTurn, '-g', 'LineWidth', 3);
title('Turning Path');
xlabel('X-Position in mm');
ylabel('Y-Position in mm');
zlabel('Z-Position in mm');

%Yaw Rate Calculation
timeTurn = timeData(turnMask);
psiTurn = psiData(turnMask);
%%Analytical Derivative
psiRate = psiTurn(2:end)-psiTurn(1:end-1);
timeRate = timeTurn(2:end)-timeTurn(1:end-1);
derivedPsiRate = psiRate./timeRate;
figure;
plot(timeTurn(1:end-1), derivedPsiRate, '-y', 'LineWidth', 3);
title('Yaw Rate');
ylabel('Yaw Rate in Radians/sec');
xlabel('Time in seconds');

flightDynamics.turn = {'Max Yaw-Rate', min(derivedPsiRate)};

%%Total Flight Color Coated
figure;
plot3(xData, yData, zData, '-k');
title('Entire Flight');
xlabel('X-Position in mm');
ylabel('Y-Position in mm');
zlabel('Z-Position in mm');
hold on
plot3(xHover,yHover,zHover,'-r','LineWidth', 3);
plot3(xStraight,yStraight,zStraight,'-b', 'LineWidth', 3);
plot3(xTurn, yTurn, zTurn, '-g', 'LineWidth', 3);

end

