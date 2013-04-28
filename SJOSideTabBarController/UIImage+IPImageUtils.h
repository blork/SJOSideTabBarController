// Usage example:
// input image: http://f.cl.ly/items/3v0S3w2B3N0p3e0I082d/Image%202011.07.22%2011:29:25%20PM.png
//
// UIImage *buttonImage = [UIImage ipMaskedImageNamed:@"UIButtonBarAction.png" color:[UIColor redColor]];

// .h
@interface UIImage (IPImageUtils)
+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color;
@end