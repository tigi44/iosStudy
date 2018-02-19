//
//  DSCircularLayoutCustom.m
//  6_CustomLayoutCollectionViewExample
//
//  Created by tigi on 2018. 2. 19..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "DSCircularLayoutCustom.h"

@implementation DSCircularLayoutCustom{
    CGFloat angleOfEachItem;
    CGFloat angleForSpacing;
    CGFloat circumference;
    long cellCount;
    long secondSectionCellCount;
    CGFloat maxNoOfCellsInCircle;
    
    CGFloat _startAngle;
    CGFloat _endAngle;
    
    NSIndexPath *deleteIndexPath;
    UICollectionUpdateAction layoutUpdateAction;
}

- (id)init {
    self = [super init];
    if (self) {
        _startAngle = M_PI;
        _endAngle = 0;
    }
    return self;
}

-(void)initWithCentre:(CGPoint)centre radius:(CGFloat)radius itemSize:(CGSize)itemSize andAngularSpacing:(CGFloat)angularSpacing{
    _centre = centre;
    _radius = radius;
    _itemSize = itemSize;
    _angularSpacing = angularSpacing;
}

-(void)setStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    _startAngle = startAngle;
    _endAngle = endAngle;
    if(_startAngle == 2*M_PI){
        _startAngle = 2*M_PI - M_PI/180;
    }
    if(_endAngle == 2*M_PI){
        _endAngle = 2*M_PI - M_PI/180;
    }
}

-(void)prepareLayout{
    [super prepareLayout];
    cellCount = [self.collectionView numberOfItemsInSection:0];
    secondSectionCellCount = [self.collectionView numberOfItemsInSection:1];
    circumference = ABS(_startAngle - _endAngle)*_radius;
    maxNoOfCellsInCircle =  circumference/(MAX(_itemSize.width, _itemSize.height) + _angularSpacing/2);
    angleOfEachItem = ABS(_startAngle - _endAngle)/maxNoOfCellsInCircle;
}

-(CGSize)collectionViewContentSize{
    CGFloat visibleAngle = ABS(_startAngle - _endAngle);
    long remainingItemsCount = cellCount > maxNoOfCellsInCircle ? cellCount - maxNoOfCellsInCircle : 0;
    CGFloat scrollableContentWidth = (remainingItemsCount+1)*angleOfEachItem*_radius/(2*M_PI/visibleAngle);
    CGFloat height = _radius + (MAX(_itemSize.width, _itemSize.height)/2);
    
    if(_scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        return CGSizeMake(height, scrollableContentWidth + self.collectionView.bounds.size.height);
    }
    return CGSizeMake(scrollableContentWidth + self.collectionView.bounds.size.width, height);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        return [self layoutAttributesForVerticalScrollForItemAtIndexPath:indexPath];
    }
    return [self layoutAttributesForHorozontalScrollForItemAtIndexPath:indexPath];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForHorozontalScrollForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat offset = self.collectionView.contentOffset.x;
    offset = offset == 0 ? 1 : offset;
    CGFloat offsetPartInMPI = offset/circumference;
    CGFloat angle = 2*M_PI*offsetPartInMPI;
    CGFloat offsetAngle = angle;
    
    attributes.size = _itemSize;
    int mirrorX = _mirrorX ? -1 : 1;
    int mirrorY = _mirrorY ? -1 : 1;
    CGFloat x = _centre.x + offset + mirrorX*(_radius*cosf(indexPath.item*angleOfEachItem - offsetAngle + angleOfEachItem/2 - _startAngle));
    CGFloat y = _centre.y + mirrorY*(_radius*sinf(indexPath.item*angleOfEachItem - offsetAngle + angleOfEachItem/2 - _startAngle));
    
    CGFloat cellCurrentAngle = (indexPath.item*angleOfEachItem + angleOfEachItem/2 - offsetAngle);
    if(cellCurrentAngle >= -angleOfEachItem/2 && cellCurrentAngle <= ABS(_startAngle - _endAngle) + angleOfEachItem/2){
        attributes.alpha = 1;
    }else{
        attributes.alpha = 0;
    }
    
    if ([indexPath section] == 0)
    {
        attributes.center = CGPointMake(x, y);
    }
    else
    {
        CGPoint sContentCenter = CGPointMake(_centre.x + self.collectionView.contentOffset.x,  _centre.y + self.collectionView.contentOffset.y);
        CGVector sVector = CGVectorMake(x - sContentCenter.x, y - sContentCenter.y);
        attributes.center = CGPointMake(x + sVector.dx/2, y + sVector.dy/2);
        if ([[[self collectionView] cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]] isSelected])
        {
            attributes.hidden = NO;
        }
        else
        {
            attributes.hidden = YES;
        }
    }
    
    attributes.zIndex = cellCount - indexPath.item;
    if(_rotateItems){
        attributes.transform = CGAffineTransformMakeRotation(cellCurrentAngle - M_PI/2);
    }
    return attributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForVerticalScrollForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat offset = self.collectionView.contentOffset.y;
    offset = offset == 0 ? 1 : offset;
    CGFloat offsetPartInMPI = offset/circumference;
    CGFloat angle = 2*M_PI*offsetPartInMPI;
    CGFloat offsetAngle = angle;
    
    attributes.size = _itemSize;
    int mirrorX = _mirrorX ? -1 : 1;
    int mirrorY = _mirrorY ? -1 : 1;
    CGFloat x = _centre.x + mirrorX*(_radius*cosf(indexPath.item*angleOfEachItem - offsetAngle + angleOfEachItem/2 - _startAngle));
    CGFloat y = _centre.y + offset + mirrorY*(_radius*sinf(indexPath.item*angleOfEachItem - offsetAngle + angleOfEachItem/2 - _startAngle));
    
    CGFloat cellCurrentAngle = indexPath.item*angleOfEachItem + angleOfEachItem/2 - offsetAngle;
    if(cellCurrentAngle >= -angleOfEachItem/2 && cellCurrentAngle <= ABS(_startAngle - _endAngle) + angleOfEachItem/2){
        attributes.alpha = 1;
    }else{
        attributes.alpha = 0;
    }
    
    if ([indexPath section] == 0)
    {
        attributes.center = CGPointMake(x, y);
    }
    else
    {
        CGPoint sContentCenter = CGPointMake(_centre.x + self.collectionView.contentOffset.x,  _centre.y + self.collectionView.contentOffset.y);
        CGVector sVector = CGVectorMake(x - sContentCenter.x, y - sContentCenter.y);
        attributes.center = CGPointMake(x + sVector.dx/2, y + sVector.dy/2);
        if ([[[self collectionView] cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]] isSelected])
        {
            attributes.hidden = NO;
        }
        else
        {
            attributes.hidden = YES;
        }
    }
    
    attributes.zIndex = cellCount - indexPath.item;
    if(_rotateItems){
        attributes.transform = CGAffineTransformMakeRotation(cellCurrentAngle - M_PI/2);
    }
    
    return attributes;
}

-(NSArray <__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray<__kindof UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    for(NSInteger i=0; i < cellCount; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *cellAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if(CGRectIntersectsRect(rect, cellAttributes.frame) && cellAttributes.alpha != 0){
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    
    for(NSInteger i=0; i < secondSectionCellCount; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
        UICollectionViewLayoutAttributes *cellAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if(CGRectIntersectsRect(rect, cellAttributes.frame) && cellAttributes.alpha != 0){
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([itemIndexPath section] == 1)
    {
        attributes.alpha = 0.2;
        attributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }
    return attributes;

}

- (UICollectionViewLayoutAttributes*)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];

    if (layoutUpdateAction != UICollectionUpdateActionDelete ||
        (layoutUpdateAction == UICollectionUpdateActionDelete && [deleteIndexPath isEqual:itemIndexPath]))
    {
        CGPoint sContentCenter = CGPointMake(_centre.x + self.collectionView.contentOffset.x,  _centre.y + self.collectionView.contentOffset.y);
        CGVector sVector = CGVectorMake(attributes.center.x - sContentCenter.x, attributes.center.y - sContentCenter.y);
        attributes.center = CGPointMake(attributes.center.x + sVector.dx, attributes.center.y + sVector.dy);
        attributes.alpha = 0.2;
        attributes.transform = CGAffineTransformScale(attributes.transform, 0.5, 0.5);
    }
    return attributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems
{
    for (UICollectionViewUpdateItem *sItem in updateItems)
    {
        if ([sItem updateAction] == UICollectionUpdateActionDelete)
        {
            if ([[sItem indexPathBeforeUpdate] section] == 0)
            {
                layoutUpdateAction = UICollectionUpdateActionDelete;
                deleteIndexPath = [sItem indexPathBeforeUpdate];
            }
        }
    }
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end


