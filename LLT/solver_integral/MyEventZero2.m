function [zPosition ,isterminal ,direction] = MyEventZero2(t,status)
parameters_user_3;
zPosition = status(1)-R_0;
isterminal = 1;
direction = 0;

end


