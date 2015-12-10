#import "VKMLayerButton.h"

@interface VKMLayerButton ()

@property (strong,nonatomic) CAGradientLayer *backgroundLayer, *highlightBackgroundLayer;
@property (strong,nonatomic) CALayer *innerGlow;

@end

@implementation VKMLayerButton

#pragma mark - UIButton Overrides

+ (VKMLayerButton *)buttonWithType:(UIButtonType)type
{
    return [super buttonWithType:UIButtonTypeCustom];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        [self drawButton];
        [self drawInnerGlow];
        
        
        if (!_highlightBackgroundLayer.hidden) {
            [self drawBackgroundLayer];
        }
        
        [self drawHighlightBackgroundLayer];
        
        _highlightBackgroundLayer.hidden = YES;
    }
    
    return self;
}

- (void)layoutSubviews
{
    // Set inner glow frame (1pt inset)
    _innerGlow.frame = CGRectInset(self.bounds, 1, 1);
    
    // Set gradient frame (fill the whole button))
    _backgroundLayer.frame = self.bounds;
    
    // Set inverted gradient frame
    CGRect rect = self.bounds;
    //rect.origin.x = rect.origin.x + 10;
    self.bounds = rect;
    _highlightBackgroundLayer.frame = self.bounds;
    
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted
{
    // Disable implicit animation
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    
    // Hide/show inverted gradient
    _highlightBackgroundLayer.hidden = !highlighted;
    [CATransaction commit];
    
    [super setHighlighted:highlighted];
}

#pragma mark - Layer setters

- (void)drawButton
{
    // Get the root layer (any UIView subclass comes with one)
    CALayer *layer = self.layer;
    
    layer.cornerRadius = 0;
    layer.borderWidth = 2;
    layer.borderColor =(__bridge CGColorRef _Nullable)((id)[UIColor colorWithRed:0.94f green:0.82f blue:0.52f alpha:1.00f].CGColor);
   // layer.borderColor = [UIColor colorWithRed:0.77f green:0.43f blue:0.00f alpha:1.00f].CGColor;
}

- (void)drawBackgroundLayer
{
    // Check if the property has been set already
    if (!_backgroundLayer)
    {
        // Instantiate the gradient layer
        _backgroundLayer = [CAGradientLayer layer];
        
        
        // Set the colors
//        _backgroundLayer.colors = (@[
//                                     (id)[UIColor colorWithRed:0.94f green:0.82f blue:0.52f alpha:1.00f].CGColor,
//                                     (id)[UIColor colorWithRed:0.91f green:0.55f blue:0.00f alpha:1.00f].CGColor
//                                     
//                                     
//                                     ]);
        
        // Set the stops
        _backgroundLayer.locations = (@[
                                        @0.0f,
                                        @1.0f
                                        ]);
        // _backgroundLayer.cornerRadius = 20;
        // Add the gradient to the layer hierarchy
        [self.layer insertSublayer:_backgroundLayer atIndex:0];
    }
}

- (void)drawHighlightBackgroundLayer
{
    if (!_highlightBackgroundLayer)
    {
        _highlightBackgroundLayer = [CAGradientLayer layer];
        _highlightBackgroundLayer.colors = (@[
                                              (id)[UIColor colorWithRed:0.94f green:0.55f blue:0.00f alpha:1.00f].CGColor,
                                              (id)[UIColor colorWithRed:0.94f green:0.82f blue:0.52f alpha:1.00f].CGColor
                                              ]);
        _highlightBackgroundLayer.locations = (@[
                                                 @0.0f,
                                                 @1.0f
                                                 ]);
        _highlightBackgroundLayer.cornerRadius = 20;
        
        [self.layer insertSublayer:_highlightBackgroundLayer atIndex:1];
    }
}

- (void)drawInnerGlow
{
    if (!_innerGlow)
    {
        // Instantiate the innerGlow layer
        _innerGlow = [CALayer layer];
        
        _innerGlow.cornerRadius= 4;
        _innerGlow.borderWidth = 1;
        _innerGlow.borderColor = [[UIColor whiteColor] CGColor];
        _innerGlow.opacity = 0.5;
        
        [self.layer insertSublayer:_innerGlow atIndex:2];
    }
}

@end
