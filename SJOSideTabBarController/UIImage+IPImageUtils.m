// Usage example:
// input image: http://f.cl.ly/items/3v0S3w2B3N0p3e0I082d/Image%202011.07.22%2011:29:25%20PM.png
//
// UIImage *buttonImage = [UIImage ipMaskedImageNamed:@"UIButtonBarAction.png" color:[UIColor redColor]];
// .m
@implementation UIImage (IPImageUtils)

+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color
{
	UIImage *image = [UIImage imageNamed:name];
	CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
	CGContextRef c = UIGraphicsGetCurrentContext();
	[image drawInRect:rect];
	CGContextSetFillColorWithColor(c, [color CGColor]);
	CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
	CGContextFillRect(c, rect);
	UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return result;
}

@end