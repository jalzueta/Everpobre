// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FLGNotebook.h instead.

@import CoreData;
#import "FLGEverpobreBaseClass.h"

extern const struct FLGNotebookAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *modificationDate;
	__unsafe_unretained NSString *name;
} FLGNotebookAttributes;

extern const struct FLGNotebookRelationships {
	__unsafe_unretained NSString *notes;
} FLGNotebookRelationships;

@class FLGNote;

@interface FLGNotebookID : NSManagedObjectID {}
@end

@interface _FLGNotebook : FLGEverpobreBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FLGNotebookID* objectID;

@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* modificationDate;

//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _FLGNotebook (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(FLGNote*)value_;
- (void)removeNotesObject:(FLGNote*)value_;

@end

@interface _FLGNotebook (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
