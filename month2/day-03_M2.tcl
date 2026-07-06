# problem -1

# question: In Post Configurator, find Output Settings. Change two things:

# File extension to .mpf
# Sequence number maximum to 99999

# soultion:
# the output file extenstion changed as below
set mom_sys_output_file_suffix                "mpf"

# format set to 5 digit.

FORMATTING
{
  WORD_SEPARATOR " "
  END_OF_LINE ""
  SEQUENCE sequence_number 10  10 1 99999
}

# problem - 2

# question: In Post Configurator, find the G/M Code Settings section. 
# Find where G01 (linear feed) is defined. Without changing anything, 
# write a comment block mapping these four codes to their Siemens 810D equivalents from your machine knowledge:

# soultion:

# G-code mapping — post default vs Siemens 810D reality
# mom_sys_rapid_code        = "0"  → G00  → 810D: SAME. Siemens natively uses G0 or G00 for rapid traverse.
# mom_sys_linear_code       = "1"  → G01  → 810D: SAME. G1 or G01 is universally standard for linear feed interpolation.
# mom_sys_circle_code(CLW)  = "2"  → G02  → 810D: SAME. G2 or G02 is universally standard for clockwise circular motion.
# mom_sys_cycle_drill_code  = "81" → G81  → 810D: DIFFERENT. G81 is the Fanuc/ISO standard. 
#                                             WHY: Natively (in G290 mode), Siemens does not use G81-G89. 
#                                             It requires conversational cycle calls with specific parameters, 
#                                             such as MCALL CYCLE82(RTP, RFP, SDIS, DP, DPR, DTB). 
#                                             The 810D will only accept G81 if forced into ISO mode (G291).

# problem-3

# question: Open your .def file in VS Code. Find the coordinate output format section — look for where decimal places are defined for X, Y, Z addresses. Write a comment explaining:

# soultion:

# What the current decimal place setting is
# What your VMC 850 actually needs
# Whether they match


# decimal places are defined inside legacy_post.def under address x for x coordinates, address y for y coordinates, address z for z coordinates.

ADDRESS X
  {
      FORMAT      Coordinate
      FORCE       off
      MAX         99999.999 Truncate
      MIN         -99999.999 Truncate
      LEADER      [$mom_sys_leader(X)]
      ZERO_FORMAT Zero_real
  }

  ADDRESS Y
  {
      FORMAT      Coordinate
      FORCE       off
      MAX         99999.999 Truncate
      MIN         -99999.999 Truncate
      LEADER      [$mom_sys_leader(Y)]
      ZERO_FORMAT Zero_real
  }

  ADDRESS Z
  {
      FORMAT      Coordinate
      FORCE       off
      MAX         99999.999 Truncate
      MIN         -99999.999 Truncate
      LEADER      [$mom_sys_leader(Z)]
      ZERO_FORMAT Zero_real
  }

# 1) current decimal place setting is 3 digits after dot for x,y,z coordiantes
# 2) VMC 850 machinine i am posting for needs the 3 digits of numbers after the dot.
# 3) legacy_post.def declariton and vmc 850 accptance of floting point digits are the same.
