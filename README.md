Compound-Paths
==============

Corona SDK Graphics 2.0 Demonstration
(and submission to Graphics 2.0 Contest 2013)


by: R.Delia S.K. Studios, LLC.

@stinkykitties
www.stinkykitties.com

Image (c) Corona Labs
www.coronalabs.com

This is a collection of code that I created while exploring the Graphics 2.0 features of the Corona SDK.

I mainly focused on the path property of an image, which allows the developer to skew the perspective of that image.

We only have 4 path points per image, by default. I wanted to see what kind of effects would be possible if the 
image were split into multiple pieces with shared paths at the edges of each image........
and then get the path points were working in unison.

I wanted to get this out there, but realize that it is a crazy mess at this point.  The main points are probably:

spriteMesh creation:
Image is selected, number of columns and rows defined (must be even number for each)
image is 'read' to get width / height for splitting function
'sprites' created from image file, nodes created (control points for path points), both put into tables
--stuff that assigns parentage of nodes... this was used in another demo where we controlled the nodes by touch and affected all nodes at the location
'compound' image  object is created
'enterframe' stub created for enterframe style events 

animation stuff:
created transition animation thing that keeps track of total animation time, so that timers can fire after the last animation has played
added 'add animation' function to take a time, and a transition function, and paramaters.
created transition function module that holds collection of transitions used in demo, and for research.
created functions for each transition that report back the 'run time' of a transition for the transition animation thing.

played with params.. forever tweaking..

If you've gotten this far, what are you waiting for?  Take a look, and see what you can do to make it better!



