<?php
	// MCavallo, CSS: vertical-align
		// vertical-align must be applied to ALL SIBLING ELEMENTS for it to work as-intended.
	
	
	// Example:
		echo '
<div style="display:inline-block; vertical-align:middle;">
	✓&nbsp;
</div>
<div style="display:inline-block; vertical-align:middle; ">
	Vertically Aligned
</div>
';

	
	// QUICK NOTE:
	// "vertical-align is intended to set the alignment of sibling elements ("elements set next to each other on a line") - not from parent to child."
	// 		User: DACrosby
	//		Reference: http://stackoverflow.com/questions/29442034/vertical-align-with-middle-of-capital-letters-instead-of-lowercase-letters
?>