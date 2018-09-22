package debugprotocol 
{



	public class CSS 
	{
		
		public function CSS() 
		{
			
		}
		public static const DependDomains:Array=[DOM];
  	
  		/**
  		 * fontsUpdated
  		 * Fires whenever a web font is updated.  A non-empty font parameter indicates a successfully loaded
  	web font
  		 * @param font:{#@type#} optional:true The web font that has loaded.
  		 * @return 
  		 */
  		public static const fontsUpdated:String = "CSS.fontsUpdated";
  	
  		/**
  		 * mediaQueryResultChanged
  		 * Fires whenever a MediaQuery result changes (for example, after a browser window has been
  	resized.) The current implementation considers only viewport-dependent media features.
  		 * @return 
  		 */
  		public static const mediaQueryResultChanged:String = "CSS.mediaQueryResultChanged";
  	
  		/**
  		 * styleSheetAdded
  		 * Fired whenever an active document stylesheet is added.
  		 * @param header:{#@type#} optional:{#@optional#} Added stylesheet metainfo.
  		 * @return 
  		 */
  		public static const styleSheetAdded:String = "CSS.styleSheetAdded";
  	
  		/**
  		 * styleSheetChanged
  		 * Fired whenever a stylesheet is changed as a result of the client operation.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const styleSheetChanged:String = "CSS.styleSheetChanged";
  	
  		/**
  		 * styleSheetRemoved
  		 * Fired whenever an active document stylesheet is removed.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} Identifier of the removed stylesheet.
  		 * @return 
  		 */
  		public static const styleSheetRemoved:String = "CSS.styleSheetRemoved";
  	
  		/**
  		 * addRule
  		 * Inserts a new rule with the given `ruleText` in a stylesheet with given `styleSheetId`, at the
  	position specified by `location`.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} The css style sheet identifier where a new rule should be inserted.
  		 * @param ruleText:string optional:{#@optional#} The text of a new rule.
  		 * @param location:{#@type#} optional:{#@optional#} Text position of a new rule in the target style sheet.
  		 * @return rule:{#@type#} optional:{#@optional#} The newly created rule.
  		 */
  		public static const addRule:String = "CSS.addRule";
  	
  		/**
  		 * collectClassNames
  		 * Returns all class names from specified stylesheet.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return classNames:array optional:{#@optional#} Class name list.
  		 */
  		public static const collectClassNames:String = "CSS.collectClassNames";
  	
  		/**
  		 * createStyleSheet
  		 * Creates a new special "via-inspector" stylesheet in the frame with given `frameId`.
  		 * @param frameId:{#@type#} optional:{#@optional#} Identifier of the frame where "via-inspector" stylesheet should be created.
  		 * @return styleSheetId:{#@type#} optional:{#@optional#} Identifier of the created "via-inspector" stylesheet.
  		 */
  		public static const createStyleSheet:String = "CSS.createStyleSheet";
  	
  		/**
  		 * disable
  		 * Disables the CSS agent for the given page.
  		 * @return 
  		 */
  		public static const disable:String = "CSS.disable";
  	
  		/**
  		 * enable
  		 * Enables the CSS agent for the given page. Clients should not assume that the CSS agent has been
  	enabled until the result of this command is received.
  		 * @return 
  		 */
  		public static const enable:String = "CSS.enable";
  	
  		/**
  		 * forcePseudoState
  		 * Ensures that the given node will have specified pseudo-classes whenever its style is computed by
  	the browser.
  		 * @param nodeId:{#@type#} optional:{#@optional#} The element id for which to force the pseudo state.
  		 * @param forcedPseudoClasses:array optional:{#@optional#} Element pseudo classes to force when computing the element's style.
  		 * @return 
  		 */
  		public static const forcePseudoState:String = "CSS.forcePseudoState";
  	
  		/**
  		 * getBackgroundColors
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to get background colors for.
  		 * @return backgroundColors:array optional:true The range of background colors behind this element, if it contains any visible text. If no
  	visible text is present, this will be undefined. In the case of a flat background color,
  	this will consist of simply that color. In the case of a gradient, this will consist of each
  	of the color stops. For anything more complicated, this will be an empty array. Images will
  	be ignored (as if the image had failed to load).
  		 */
  		public static const getBackgroundColors:String = "CSS.getBackgroundColors";
  	
  		/**
  		 * getComputedStyleForNode
  		 * Returns the computed style for a DOM node identified by `nodeId`.
  		 * @param nodeId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return computedStyle:array optional:{#@optional#} Computed style for the specified DOM node.
  		 */
  		public static const getComputedStyleForNode:String = "CSS.getComputedStyleForNode";
  	
  		/**
  		 * getInlineStylesForNode
  		 * Returns the styles defined inline (explicitly in the "style" attribute and implicitly, using DOM
  	attributes) for a DOM node identified by `nodeId`.
  		 * @param nodeId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return inlineStyle:{#@type#} optional:true Inline style for the specified DOM node.
  		 */
  		public static const getInlineStylesForNode:String = "CSS.getInlineStylesForNode";
  	
  		/**
  		 * getMatchedStylesForNode
  		 * Returns requested styles for a DOM node identified by `nodeId`.
  		 * @param nodeId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return inlineStyle:{#@type#} optional:true Inline style for the specified DOM node.
  		 */
  		public static const getMatchedStylesForNode:String = "CSS.getMatchedStylesForNode";
  	
  		/**
  		 * getMediaQueries
  		 * Returns all media queries parsed by the rendering engine.
  		 * @return medias:array optional:{#@optional#} {#@description#}
  		 */
  		public static const getMediaQueries:String = "CSS.getMediaQueries";
  	
  		/**
  		 * getPlatformFontsForNode
  		 * Requests information about platform fonts which we used to render child TextNodes in the given
  	node.
  		 * @param nodeId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return fonts:array optional:{#@optional#} Usage statistics for every employed platform font.
  		 */
  		public static const getPlatformFontsForNode:String = "CSS.getPlatformFontsForNode";
  	
  		/**
  		 * getStyleSheetText
  		 * Returns the current textual content for a stylesheet.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return text:string optional:{#@optional#} The stylesheet text.
  		 */
  		public static const getStyleSheetText:String = "CSS.getStyleSheetText";
  	
  		/**
  		 * setEffectivePropertyValueForNode
  		 * Find a rule with the given active property for the given node and set the new value for this
  	property
  		 * @param nodeId:{#@type#} optional:{#@optional#} The element id for which to set property.
  		 * @param propertyName:string optional:{#@optional#} {#@description#}
  		 * @param value:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const setEffectivePropertyValueForNode:String = "CSS.setEffectivePropertyValueForNode";
  	
  		/**
  		 * setKeyframeKey
  		 * Modifies the keyframe rule key text.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param range:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param keyText:string optional:{#@optional#} {#@description#}
  		 * @return keyText:{#@type#} optional:{#@optional#} The resulting key text after modification.
  		 */
  		public static const setKeyframeKey:String = "CSS.setKeyframeKey";
  	
  		/**
  		 * setMediaText
  		 * Modifies the rule selector.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param range:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param text:string optional:{#@optional#} {#@description#}
  		 * @return media:{#@type#} optional:{#@optional#} The resulting CSS media rule after modification.
  		 */
  		public static const setMediaText:String = "CSS.setMediaText";
  	
  		/**
  		 * setRuleSelector
  		 * Modifies the rule selector.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param range:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param selector:string optional:{#@optional#} {#@description#}
  		 * @return selectorList:{#@type#} optional:{#@optional#} The resulting selector list after modification.
  		 */
  		public static const setRuleSelector:String = "CSS.setRuleSelector";
  	
  		/**
  		 * setStyleSheetText
  		 * Sets the new stylesheet text.
  		 * @param styleSheetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param text:string optional:{#@optional#} {#@description#}
  		 * @return sourceMapURL:string optional:true URL of source map associated with script (if any).
  		 */
  		public static const setStyleSheetText:String = "CSS.setStyleSheetText";
  	
  		/**
  		 * setStyleTexts
  		 * Applies specified style edits one after another in the given order.
  		 * @param edits:array optional:{#@optional#} {#@description#}
  		 * @return styles:array optional:{#@optional#} The resulting styles after modification.
  		 */
  		public static const setStyleTexts:String = "CSS.setStyleTexts";
  	
  		/**
  		 * startRuleUsageTracking
  		 * Enables the selector recording.
  		 * @return 
  		 */
  		public static const startRuleUsageTracking:String = "CSS.startRuleUsageTracking";
  	
  		/**
  		 * stopRuleUsageTracking
  		 * Stop tracking rule usage and return the list of rules that were used since last call to
  	`takeCoverageDelta` (or since start of coverage instrumentation)
  		 * @return ruleUsage:array optional:{#@optional#} {#@description#}
  		 */
  		public static const stopRuleUsageTracking:String = "CSS.stopRuleUsageTracking";
  	
  		/**
  		 * takeCoverageDelta
  		 * Obtain list of rules that became used since last call to this method (or since start of coverage
  	instrumentation)
  		 * @return coverage:array optional:{#@optional#} {#@description#}
  		 */
  		public static const takeCoverageDelta:String = "CSS.takeCoverageDelta";
	}

}