%initialize parameters
m = 0.175; % kg
g = 9.81; % m/s^2
d = 0.26; % m
d_air = 1.23; % kg/m^3
Vinit = 14; % m/s
hinit = 1; %m
ang_att = 5 * pi / 180; %radians
A = pi/2*d^2*sin(ang_att); % m^2
Vx_init = Vinit*cos(ang_att);
Vy_init = Vinit*sin(ang_att);
Cd0 = 0.08; %drag coefficient at alpha = 0
Cl0 = 0.15; %lift coefficient at alpha = 0
CdA = 2.72; %drag coefficient dependant on alpha
ClA = 1.4; %drag coefficient dependant on alpha
A0 = -4*pi/180; %radians
delta_time = 0.001;
%find the coefficient of drag
C_drag = @(ang_att) Cd0 + CdA*(ang_att-A0)^2;
%find the coefficient of lift
C_lift = @(ang_att) Cl0 + ClA*(ang_att);
C_drag_val = C_drag(ang_att);
C_lift_val = C_lift(ang_att);
%set the first element of each array to the initial conditions
vx_arr(1) = Vx_init;
vy_arr(1) = Vy_init;
x_arr(1) = 0;
y_arr(1) = hinit;
i = 1;
%keeps looping until the frisbee hits the ground (y = 0)
while y_arr(end) >= 0
%new x position is the old x position plus the change in the time multiplied by the current velocity in the x-direction
new_x = x_arr(i) + delta_time*vx_arr(i);
%new y position is the old y position plus the change in the time multiplied by the current velocity in the y-direction
new_y = y_arr(i) + delta_time*vy_arr(i);
new_vx = vx_arr(i) - (C_drag_val * d_air*A*vx_arr(i)^2)* (delta_time/(2*m));
new_vy = vy_arr(i) + (delta_time/m)*(0.5*C_lift_val*d_air*A*vx_arr(i)^2 - m*g) - ((C_drag_val * d_air*A*vy_arr(i)^2/2) * (delta_time/m));
i = i+1;
%set prev vx, vy, x, y to current vx, vy, x, y
vx_arr(i) = new_vx;
vy_arr(i) = new_vy;
x_arr(i) = new_x;
y_arr(i) = new_y;
end
%display x and y arr
plot(x_arr, y_arr);
%set the x and y axis
ylim([0 10]);
xlim([0 20]);
%set the ratio of x and y to be 1:1
daspect([1 1 1]);
%clear arrays
clear('x_arr');
clear('y_arr');
clear('vx_arr');
clear('vy_arr');
