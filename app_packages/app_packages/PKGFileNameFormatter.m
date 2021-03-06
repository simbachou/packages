/*
Copyright (c) 2008-2016, Stephane Sudre
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
- Neither the name of the WhiteBox nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "PKGFileNameFormatter.h"

@implementation PKGFileNameFormatter

- (NSAttributedString *)attributedStringForObjectValue:(id)inObject withDefaultAttributes:(NSDictionary *)attrs
{
	if ([inObject isKindOfClass:NSAttributedString.class]==YES)
		return inObject;
	
	if ([inObject isKindOfClass:NSString.class]==YES)
		return [[NSAttributedString alloc] initWithString:inObject attributes:attrs];
			
	return nil;
}

- (NSString *)stringForObjectValue:(id)inObject
{
	if (inObject==nil)
		return @"";
	
	if ([inObject isKindOfClass:NSString.class])
		return inObject;
	
	if ([inObject isKindOfClass:NSAttributedString.class]==YES)
		return ((NSAttributedString *)inObject).string;
	
	return @"";
}

- (BOOL)getObjectValue:(out id *)obj forString:(NSString *)string errorDescription:(NSString **)error
{
    *obj=[string copy];
     
    return YES;
}

- (BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString **)newString errorDescription:(NSString **)error
{
   NSUInteger tLength=partialString.length;
    
    if (tLength>=256)
    {
        *newString=nil;
            
        *error=@"Error";
            
        return NO;
    }
    
    if (tLength>0)
    {
        if (self.fileNameCanStartWithDot==NO)
        {
             unichar tUniChar=[partialString characterAtIndex:0];
            
            if (tUniChar=='.')
            {
                *newString=nil;
                
                *error=@"Error";
                
                return NO;
            }
        }
        
        for(NSUInteger i=0;i<tLength;i++)
        {
             unichar tUniChar=[partialString characterAtIndex:i];
            
            if (tUniChar=='/')
            {
                *newString=nil;
                
                *error=@"Error";
                
                return NO;
            }
        }
    }
    
    return YES;
}

@end
