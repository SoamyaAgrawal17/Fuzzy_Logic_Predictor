function [ val ] = signedDistance( a1l,a2l,a3l,a4l,hal,a1u,a2u,a3u,a4u,hau)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
val1=a1l+a2l+a3l+a4l;
val2=((2*hau)+(3*hal))/hau;
val2=val2*(a2u+a3u);
val3=((4*hau)-(3*hal))/hau;
val3=val3*(a1u+a4u);
val=(val1+val2+val3)/8;


end