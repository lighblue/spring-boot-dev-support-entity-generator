# spring-boot-dev-support-entity-generator

copy plugins/*.jar to Eclipse's plugins folder and restart Eclipse

## Example

1. create a new file TestUser.hdl in src/main/java/com/truneo/test/model/entity
<pre><code>
    import com.truneo.test.enums.TestUserStatusEnum

    package com.truneo.test.model.^entity {
        entity TestUser {
            id : Integer "id"
            name : String "user name"
            status : TestUserStatusEnum "user status"
        }
    }
</code></pre>

2. save the file, TestUserDO.java will be generated in /src-gen/com/truneo/test/model/entity
```java
package com.truneo.test.model.entity;

import lombok.Builder;
import lombok.Data;
import javax.persistence.*;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import com.truneo.test.enums.TestUserStatusEnum;

@Data
@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "test_user", schema = "", catalog = "")
@Valid
@ApiModel("TestUserDO")
public class TestUserDO {
    @ApiModelProperty(notes = "The database generated order ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ApiModelProperty(notes = "user name", required = true)
    @NotNull(message = "user name")
    @Column(name = "name")
    private String name;
    
    @ApiModelProperty(notes = "user status", required = true)
    @NotNull(message = "user status")
    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private TestUserStatusEnum status;
    
}
```
3. If you want to modify the generated java file, please delete the hdl file. Otherwise, your changes will be overwritten
