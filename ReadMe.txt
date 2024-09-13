After days of working i finally worked out the best solution for this. instead of using Rigidbodies and complicating things with physics 
applying impluse with many different physics properties to mess around. I used a Characterbody instead. Its much simpler for basic task
like pushing and pulling object around. This took me quite a while to get a smooth movement by using lerp and playing around with acceleration
values to avoid jitter. Also pulling issues was very annoying until i came up with using a raycast in both direction to check if its colliding
then it can enters pulling state, i also had to make the player movement synchronise with the moving object speed.
