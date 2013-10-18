#!/bin/bash

bmptopnm <$1 >logo.pnm
ppmtolss16 <logo.pnm >logo.16_