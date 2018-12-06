package com.truneo.hdl.jvmmodel
import org.eclipse.xtext.generator.*;
import javax.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.xtext.xbase.compiler.TypeReferenceSerializer
import org.eclipse.emf.ecore.resource.Resource
import com.truneo.hdl.hDL.Entity
import org.eclipse.xtext.xbase.compiler.ImportManager
import org.eclipse.xtext.common.types.JvmTypeReference
import org.eclipse.xtext.xbase.compiler.StringBuilderBasedAppendable
import com.truneo.hdl.hDL.Feature

class DomainmodelGenerator implements IGenerator {
  
  @Inject extension IQualifiedNameProvider
  @Inject extension TypeReferenceSerializer 
 
  override void doGenerate(Resource resource, IFileSystemAccess fsa) {
    for(e: resource.allContents.toIterable.filter(typeof(Entity))) {
      fsa.generateFile(
        e.fullyQualifiedName.toString("/") + "DO.java",
        e.compile)
    }
  }
  
  def compile(Entity it) '''
    «val importManager = new ImportManager(true)» 
    «val body = body(importManager)»
    «IF eContainer != null»
      package «eContainer.fullyQualifiedName»;
    «ENDIF»
    
    import lombok.Builder;
    import lombok.Data;
    import javax.persistence.*;
    import javax.validation.Valid;
    import javax.validation.constraints.NotNull;
    import io.swagger.annotations.ApiModel;
    import io.swagger.annotations.ApiModelProperty;
    import lombok.AllArgsConstructor;
    import lombok.NoArgsConstructor;
    «FOR i:importManager.imports»
      import «i»;
    «ENDFOR»
    
    «body»
  '''
  
  def body(Entity it, ImportManager importManager) '''
    @Data
    @Builder
    @Entity
    @NoArgsConstructor
    @AllArgsConstructor
    @Table(name = "table_name", schema = "qqmall", catalog = "")
    @Valid
    @ApiModel("«name»DO")
    public class «name»DO «IF superType != null»
        extends «superType.shortName(importManager)» «ENDIF»{
        «FOR f : features»
            «f.compile(importManager)»
        «ENDFOR»
    }
  '''
    
  def compile(Feature it, ImportManager importManager) '''
«««    «IF it instanceof  »
    «IF "id".equals(name) »
        @ApiModelProperty(notes = "The database generated order ID")
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
    «ELSE»
        @ApiModelProperty(notes = "«desc»", required = true)
        @NotNull(message = "«desc»")
        @Column(name = "order_number")
    «ENDIF»
    private «type.shortName(importManager)» «name»;
    
«««    public «type.shortName(importManager)» get«name.toFirstUpper»() {
«««        return «name»;
«««    }
«««   
«««    public void set«name.toFirstUpper»(«type.shortName(importManager)» «name») {
«««        this.«name» = «name»;
«««    }
  '''
  
  def shortName(JvmTypeReference ref, 
          ImportManager importManager) {
    val result = new StringBuilderBasedAppendable(importManager)
    ref.serialize(ref.eContainer, result);
    result.toString
  }
}